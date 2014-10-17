mkfsオプションサンプル
=====

# ext4

## オプション

Dry-Runモード

	mkfs.ext4 /dev/xvdx1 -n

容量あたりのi-node数指定(1024～)

	mkfs.ext4 /dev/xvdx1 -i 65536

直接i-node数指定(25600単位)

	mkfs.ext4 /dev/xvdx1 -i 65536

root様専用ディスクスペースを確保しない(単位:%)

	mkfs.ext4 /dev/xvdx1 -m 0

## ビルド例

大きいファイルが多いストレージ用

	mkfs.ext4 /dev/xvdx1 -i 1048576 -m 0
