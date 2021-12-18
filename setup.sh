#!/bin/sh

# variable: root password
pass="<PASSWORD>"

# variable: git user name
name="<USER_NAME>"

# variable: git user email
email="${name}@gmail.com"

# variable: docker-compose version
dcv="1.26.0"

# ファイアウォールの起動
echo $pass | sudo ufw enable

# packageの最新化
echo $pass | sudo apt update

# gitのインストール
echo $pass | sudo apt-get install git

# gitの実行確認
dpkg -l git

# gitの初期設定
git config --global user.name $name
git config --global user.email $email

# dockerのインストール
echo $pass | sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
echo $pass | sudo apt update
echo $pass | sudo apt install docker-ce

# dockerの実行確認
echo $pass | sudo systemctl status docker

# SudoなしでDockerコマンドを実行できるよう設定
echo $pass | sudo usermod -aG docker ${USER}
su - ${USER}

# ユーザーがdockerグループに追加されたことを確認
id -nG

# docker-composeをインストール
echo $pass | sudo curl -L "https://github.com/docker/compose/releases/download/${dcv}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# docker-composeコマンドが実行可能になるように権限を設定
echo $pass | sudo chmod +x /usr/local/bin/docker-compose

# docker-composeの実行確認
docker-compose --version

# ネットワークドライバのインストール Realtek_r8125
cd lan_driver
docker-compose up
cd ..

