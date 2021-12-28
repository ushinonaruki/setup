#!/bin/sh

# variable: root password
pass="<PASSWORD>"

# variable: git user name
name="<USER_NAME>"

# variable: git user email
email="${name}@gmail.com"

# variable: docker-compose version
dcv="1.26.0"

# echo: firewall
echo '----- ufw -----'

# ファイアウォールの起動
echo $pass | sudo ufw enable

# packageの最新化
echo $pass | sudo apt update

# echo: git
echo '----- git -----'

# gitのインストール
echo $pass | yes | sudo apt-get install git

# gitの初期設定
git config --global user.name $name
git config --global user.email $email

# echo: docker
echo '----- docker -----'

# aptがHTTPS経由でパッケージを使用できるようにするいくつかの必要条件パッケージをインストール
echo $pass | yes | sudo apt install apt-transport-https ca-certificates curl software-properties-common

# 公式DockerリポジトリのGPGキーをシステムに追加
echo $pass | curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# DockerリポジトリをAPTソースに追加
echo $pass | sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

# 追加されたリポジトリからDockerパッケージでパッケージデータベースを更新
echo $pass | sudo apt update

# Dockerをインストール
echo $pass | yes | sudo apt install docker-ce

# SudoなしでDockerコマンドを実行できるよう設定
echo $pass | sudo usermod -aG docker ${USER}

# echo: docker
echo '----- docker-compose -----'

# docker-composeをインストール
echo $pass | sudo curl -L "https://github.com/docker/compose/releases/download/${dcv}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# docker-composeコマンドが実行可能になるように権限を設定
echo $pass | sudo chmod +x /usr/local/bin/docker-compose

# echo: lan driver
echo '----- lan driver -----'

# ネットワークドライバのインストール Realtek_r8125
cd lan_driver
echo $pass | sudo docker-compose up -d


# echo: 実行確認
echo '----- 実行確認 -----'

# gitの実行確認
echo '----- git version -----'
git version

# dockerの実行確認
echo '----- docker version -----'
echo $pass | sudo docker version

# docker-composeの実行確認
echo '----- docker-compose --version -----'
echo $pass | sudo docker-compose --version
