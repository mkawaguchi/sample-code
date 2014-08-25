SSL証明書インストール手順
=====
- - -
# 概要
* SSL証明書を申請書作成からインストールするまでの手順。
* 秘密鍵にはパスワードは設定しない。

# 事前に決めておくこと
* SSL証明書を取得するドメイン名 (例:example.com)
* 秘密鍵のビット数(例：4096)
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

### 発行を待つ

### ウェブサーバーへインストール

あとで書く
