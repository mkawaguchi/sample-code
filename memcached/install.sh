#!/bin/sh

ROOT=`dirname $0`
DIR="/var/memcached"

# ディレクトリを掘る
echo "ディレクトリ $DIR を作成します"
mkdir $DIR
chown memcached:memcached $DIR

# サービス起動スクリプトを配置する
echo "サービス起動スクリプト memcached_socket を配置します"
cp $ROOT/init.d/memcached_socket /etc/rc.d/init.d/memcached_socket
chmod 755 /etc/rc.d/init.d/memcached_socket

# コンフィグファイルを配置する
echo "コンフィグファイル /etc/sysconfig/memcached_socket を配置します"
cp $ROOT/sysconfig/memcached_socket /etc/sysconfig/memcached_socket

# サービス登録
echo "サービス登録を行います"
chkconfig --add memcached_socket

# 完了
echo "インストールが完了しました"

