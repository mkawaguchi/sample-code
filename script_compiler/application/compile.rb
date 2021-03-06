#!/usr/local/bin/ruby
# encoding:utf-8
# SASS/LESSの動的コンパイル

# スタイルシートディレクトリ指定
STYLESHEET_DIR=File.expand_path(File.dirname(__FILE__)+"/compass-stylesheets/1.0.1/")

# Javascriptコンパイラの指定
JS_COMPILER = File.expand_path(File.dirname(__FILE__)+"/closure/v20140923/compiler.jar")

# 使用ライブラリ定義
require "cgi"
require "sass"
require "tempfile"
require "json"

# SASSのコンパイル
def compile_sass(source)
	begin
		css = Sass.compile(source,{
			:style => :compressed,
			:load_paths => [ STYLESHEET_DIR ],
		});
	rescue => e
		return {
			succeed: false,
			error:   e.message,
			output:  nil,
		}
	end
	return {
		succeed: true,
		error:   nil,
		output:  css
	}
end

# LESSのコンパイル
def compile_less(source)
	output = nil
	IO.popen("lessc -x -","r+") do |fp|
		fp.write(source)
		fp.close_write
		output = fp.read
	end
	return {
		succeed: true,
		error:   nil,
		output:  output
	}
end

# Javascriptのコンパイル
def compile_javascript(source)
	cmd = [
		"java -jar #{JS_COMPILER}",
		"--compilation_level SIMPLE",
		"--js /dev/stdin",
	].join(" ")
	
	begin
		output = nil
		IO.popen(cmd,"r+") do |fp|
			fp.write(source)
			fp.close_write
			output = fp.read
		end
	rescue e
		# nop
	end
	
	return {
		succeed: true,
		error:   nil,
		output:  output
	}
end

# Javascriptのコンパイル(mapファイル生成)
def compile_javascript_map(source,val_file,val_sources)
	# テンポラリファイル作成
	tmp =  Tempfile.new("js-compiler-")
	tmp.close()
	
	cmd = [
		"java -jar #{JS_COMPILER}",
		"--compilation_level SIMPLE",
		"--create_source_map /dev/stdout",
		"--source_map_format V3",
		"--js /dev/stdin",
		"--js_output_file #{tmp.path}",
	].join(" ")
	
	output = nil
	begin
		json_str = nil
		IO.popen(cmd,"r+") do |fp|
			fp.write(source)
			fp.close_write
			json_str = fp.read
		end
		
		data = JSON.parse(json_str)
		data["file"] = val_file
		data["sources"][0] = val_sources
		
		output = data.to_json
	rescue e
		# nop
	end
	
	# 一時ファイル削除
	tmp.unlink()
	
	return {
		succeed: true,
		error:   nil,
		output:  output
	}
end

# 結果出力
def output_result(body,header,status)
	print "Status: #{status}\n"
	header.each do |k,v|
		print "#{k}: #{v}\n"
	end
	print "\n"
	print body
end

# パラメータ取得
def take_param(cgi,key,default=nil)
	if cgi.params.has_key?(key)
		return cgi.params[key].join.to_s
	end
	return default
end

# POST:コンパイル実行
def mode_post(cgi)
	# ソース取得
	source = take_param(cgi,"source")
	if source==nil
		output_result("no input",{},400)
		exit
	end
	
	# コンパイラ指定取得
	mode = take_param(cgi,"compiler")
	
	# コンパイル
	result = case mode
	when "sass"
		compile_sass(source)
	when "less"
		compile_less(source)
	when "javascript"
		compile_javascript(source)
	when "javascript-map"
		val_file    = take_param(cgi,"val_file","untitled.min.js")
		val_sources = take_param(cgi,"val_sources","untitled.js")
		compile_javascript_map(source,val_file,val_sources)
	else
		output_result("invalid compiler",{},400)
	end
	
	# 結果判定
	if result[:succeed]
		output_result(result[:output],{ "Content-Type" => "text/css" },200)
	else
		output_result(result[:error],{},400)
	end
	
	# 終了
	exit 0
end

# メイン
def main()
	cgi = CGI.new
	
	case cgi.request_method.to_s.downcase
	when "post"
		mode_post(cgi)
	else
		output_result("",{},400)
	end
end

# 実行
main()
