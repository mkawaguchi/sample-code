SSHFS
=====

## 概要

リモートサーバー(Linux)のディレクトリをSSHFSを使ってWindowsのドライブとしてマウントする。

### 事前準備

決めておくこと

- 秘密鍵のファイル名 ... sshfs-key.ppk
- 公開鍵のファイル名 ... sshfs-key.pub
- 秘密鍵のパスワード

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

### 手順2 公開鍵を登録する

1. リモートサーバー側のユーザーホームディレクトリに .ssh/authorized_keys というファイルを作成し、公開鍵を追記する。
1. .sshディレクトリは chmodコマンドで属性を700にしておく。
1. .ssh/authorized_keys ファイルも同様に属性を600にしておく。

### 手順3 SSHFSでサーバーを登録する

1. SSHFS Managerを起動する。
1. 左下の "+ Add" をクリック。
1. "Drive Name"に任意の接続情報名を入力する。
1. "Host", "Port", "UserName" を埋める。
1. "Authentication method" は "PrivateKey" にする。
1. "PrivateKey" で秘密鍵ファイルを選択する。
1. ファイル名の下の入力欄に秘密鍵パスワードを入力する。
1. 以降の設定はお好みで。
1. "Save" をクリックして入力内容を保存する。

### 手順4 接続する

1. SSHFS Managerを起動する。
1. "Mount" をクリックして接続する。
1. Windowsのエクスプローラを開くと「リムーバブル記憶デバイス」としてマウントされているので利用を開始する。
