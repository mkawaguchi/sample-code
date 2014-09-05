SSL証明書インストール手順
=====
### 概要
* SSL証明書を申請書作成からインストールするまでの手順。
* 秘密鍵にはパスワードは設定しない。

### 事前に決めておくこと
* SSL証明書を取得するドメイン名 (例:example.com)
* 秘密鍵のビット数(例：4096)
* 有効期間(1年～5年)
* 組織名(英語)
* 部門名(英語)
* 国名コード(日本ならば"JP")
* 都道府県名(英語)
* 市区町村名(英語)

- - -
### 秘密鍵と署名請求書(CSR)の作成

	# 各種変数の定義
	export DOMAIN=example.com
	export NUMBITS=4096
	export ORG="Sample Company"
	export UNIT="Development Dept"
	export COUNTRY="JP"
	export PREF="Tokyo"
	export CITY="Chuo-ku"
	
	# 秘密鍵の作成
	openssl genrsa -out $DOMAIN.key $NUMBITS
	
	# 署名請求書(CSR)の作成
	echo -e "$COUNTRY\n$PREF\n$CITY\n$ORG\n$UNIT\n$DOMAIN\n\n\n" | openssl req -new -key $DOMAIN.key -out $DOMAIN.csr -sha1
	
	# 内容の確認
	openssl req -noout -text -in $DOMAIN.csr

### 署名請求書(CSR)をSSL証明書発行業者に提出

クソ安いSSL証明書発行業者一覧

* http://www.rapid-ssl.jp/

### お金を払う
クレジットカードまたは銀行振込

### 発行を待つ
決済が完了してしばらくすると確認メールが来る。
確認画面で承認ボタンを押すとメールでSSL証明書が送られてくる。

### ウェブサーバーへインストール

バーチャルホスト設置で以下のように各ファイルへのパスを指定する。

	SSLCertificateFile      /etc/httpd/ssl/example.com.crt
	SSLCertificateKeyFile   /etc/httpd/ssl/example.com.key
	SSLCertificateChainFile /etc/httpd/ssl/example.com.ca

中間証明書(.ca)が要らない証明書もあるが、だいたい高級品。
- - -
### SSL証明書に関する基礎知識

SSL証明書を導入することで可能になること

1. サイト利用者(ブラウザ)と接続先サーバーとの間の通信経路を暗号化することができる。
	* 悪意の第三者による盗聴を防ぐことができる。
	* 悪意の第三者による改竄を検知することができる。
1. 通信先のサーバーの所有者と、通信先URLのドメイン名の所有者が一致していることを利用者に証明することができる。
	* 悪意の第三者によるDNS汚染＋フィッシングのコンボ攻撃を防ぐことができる。

高額なSSL証明書に付いている機能（利用者視点）

1. 通信先サーバーの所有者の組織名と、その実在を確認することができる。
	* アドレスバーが緑色になるアレ
	* 証明書発行申請者の実在確認審査があるのでパスしないといけない。
	* むちゃくちゃ高い
1. 幅広いモバイル端末に対応できる
	* 逆を言うと、古いフィーチャーフォンでは対応していない機種がある。
	* スマートフォンでも念のため確認が必要。新しいものはだいたい大丈夫なはずだけど。
	* ちょっとだけ高い。というかむしろこれが標準価格。
1. ドメイン名以下のホスト名をワイルドカードにできる
	* ホスト名を量産するときにオススメ
	* こちらもブラウザ側の実装で対応していないとダメなので要注意
	* そこそこ高いけど10ホスト名くらい使うなら元がとれる。
