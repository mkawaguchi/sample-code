SSHFS
=====

## 概要

リモートサーバー(Linux)のディレクトリをDokan+Win-sshfsを使ってWindowsのドライブとしてマウントする。

### 事前準備

概要
- PuTTYgenをインストールする
- PuTTYgenで鍵ペア(公開鍵と秘密鍵)を作成する
  - 秘密鍵は他人に盗まれないよう厳重に保管すること。
  - 公開鍵は他人に見られても良いのでメールで本文に貼り付けて送っても良い。
- Dokan ライブラリをインストールする
- Win-sshfsをインストールする

決めておくこと
- 秘密鍵のファイル名 ... sshfs-key.ppk
- 公開鍵のファイル名 ... sshfs-key.pub
- 秘密鍵のパスワード

揃えておくべき情報
- リモートサーバーの接続情報
  - ホストアドレス
  - ユーザー名
  - ポート番号(デフォルトでは22)

## ダウンロード

PuTTYgen ... 鍵ペアの作成ツール
- [ダウンロードページ](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) "The latest release version"の puttygen.exe をダウンロードする
- [参考ページ](http://www.tempest.jp/security/keygen.html) PuTTYgenの利用

Dokanライブラリ
- [ダウンロードページ](http://dokan-dev.net/download/) 「Dokanライブラリ」と「Dokan SSHFS」をそれぞれダウンロードする

Win-sshfs
- [ダウンロードページ](https://code.google.com/p/win-sshfs/downloads/list) win-sshfs-0.0.1.5-setup.exeをダウンロードする

## 導入手順

### 手順1 PuTTYgenで鍵ペアを作成する

1. PuTTYgenを起動する
1. ヘッダーメニューの "Key" から "SSH2-DSA key" を選択する。
1. 画面下の "Parameters" パネルのラジオボタン "SSH-2 DSA" を選択する。
1. "Number of in a generated key" は1024で良い。
1. 画面中央の "Actions" パネルにある "Generate" ボタンをクリックする。
1. 画面上部の "Key" パネルの中でマウスをグリグリする。
1. "Key" パネル内の "Key passphrase" に秘密鍵パスワードを入力する。
1. 同じく"Key" パネル内の "Confirm passphrase" に同じ秘密鍵パスワードをもう一度入力する。
1. "Key" パネル内の "Public key for pasting into OpenSSH authorized_keys file:" の中身をコピーしてテキストファイルとして sshfs-key.pub に保存する。（公開鍵）
1. ヘッダーメニュー "Conversions" から "Export OpenSSH Key" を選択して、sshfs-key.ppkというファイル名で保存する。（秘密鍵）

### 手順2-a 公開鍵を登録する

リモートサーバーの管理者が自分である場合

1. リモートサーバー側のユーザーホームディレクトリに .ssh/authorized_keys というファイルを作成し、公開鍵を追記する。
1. .sshディレクトリは chmodコマンドで属性を700にしておく。
1. .ssh/authorized_keys ファイルも同様に属性を600にしておく。

### 手順2-b 公開鍵を提出する

リモートサーバーの管理者が他人である場合

1. 公開鍵をメールで提出する。公開鍵ファイルの中身を本文に直接貼り付けても良い。

### 手順3 DokanライブラリとWin-sshfsをインストールする

1. DokanのダウンロードページからDokanライブラリのインストーラをダウンロードする
1. インストーラを起動してDokanライブラリのインストールを実行する
1. Win-sshfsのダウンロードページからインストーラをダウンロードする
1. インストーラを起動してWin-sshfsのインストールを実行する

### 手順4 Win-sshfsでサーバーを登録する

1. タスクトレイのWin-sshfsのアイコンを右クリックして、"Show Manager"をクリックし、Sshfs Managerを起動する。
1. 左下の "+ Add" をクリック。
1. "Drive Name"に任意の接続情報名を入力する。
1. "Host", "Port", "UserName" を埋める。
1. "Authentication method" は "PrivateKey" にする。
1. "PrivateKey" で秘密鍵ファイルを選択する。
1. ファイル名の下の入力欄に秘密鍵パスワードを入力する。
1. 以降の設定はお好みで。
1. "Save" をクリックして入力内容を保存する。

### 手順5 接続する

1. SSHFS Managerを起動する。
1. 接続先を選択し、"Mount" をクリックして接続する。
1. Windowsのエクスプローラを開くと「リムーバブル記憶デバイス」としてマウントされているので利用を開始する。
