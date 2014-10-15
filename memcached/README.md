memcachedのUNIXドメインソケット版
=====

## セットアップ

インストーラーを実行する

	sudo sh install.sh

コンフィグを編集する

	vim /etc/sysconfig/memcached_socket

サービスを起動する

	service memcached_socket start

サービスの自動起動設定を行う

	chkconfig memcached_socket on
