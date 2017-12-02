#!/bin/sh


#------------------------------------#
# レポジトリの追加
#------------------------------------#
# RPM Fusionレポジトリを追加
sudo dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Adobeリポジトリ
sudo rpm -ivh http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux

# Coprレポジトリ
sudo dnf copr enable sergiomb/google-drive-ocamlfuse


#------------------------------------#
# dnf update
#------------------------------------#
# まずは更新
sudo dnf update -y


#------------------------------------#
# dnf update
#------------------------------------#
#必要なプログラムをダウンロード
sudo dnf install -y \
	gimp \
	inkscape \
	openssh \
	rsync \
	gnome-tweak-tool \
	ibus-mozc \
	nkf \
	clamav \
	clamav-update \
	heroku \
	vlc \
	unzip \
	evince \
	w3m \
	haskell-platform \
	zsh \
	xsel \ 			#クリップボードに標準出力をコピーする

# python
sudo dnf install -y \
	python3-devel \
	python-devel \

# git
sudo dnf install -y \
	git \
	hub \
	
# vim
sudo dnf install -y \
	vim-enhanced \
	vim-X11 \

# java web
sudo dnf install -y \
	icedtea-web \
	java-openjdk \

# flash player
sudo dnf install -y \
	flash-plugin \
	alsa-plugins-pulseaudio \
	libcurl

# google chrome
URL=https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo dnf install -y ${URL}
# chromeにlineを追加する

# google drive
sudo dnf install -y \
	google-drive-ocamlfuse
mkdir ~/googledrive
# 以下でマウントできる
google-drive-ocamlfuse ~/googledrive

# mozcのキーボードレイアウトをjpにする
# settings -> Resion & Language -> Input SourcesからJapanese (Mozc)を追加
sudo vim /usr/share/ibus/component/mozc.xml
#<layout>jp</layout>


# 再起動後にmozcにinputを変更する 
reboot

sudo pip3 install trash-cli


# clam av
sudo dnf install -y \
	clamav \
	clamav-update \

# 8行目：コメントにする
vim /etc/freshclam.conf 
#Example
vim /etc/sysconfig/freshclam
# 最終行：コメントにする
#FRESHCLAM_DELAY=disabled-warn
# 定義ファイル更新
freshclam

#
clamscan --infected --remove --recursive . 


#------------------------------------#
# node.js
#------------------------------------#
# nvm
git clone https://github.com/creationix/nvm.git ~/.nvm
cd ~/.nvm
git fetch
source ~/.nvm/nvm.sh

# nodeをインストール
nvm install stable
node -v

# npm
sudo dnf install -y npm

# bower
npm install bower -g

#------------------------------------#
# heroku
#------------------------------------#
sudo cd /usr/src
sudo mkdir heroku
cd heroku
sudo wget https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz -O heroku.tar.gz
sudo tar -xvzf heroku.tar.gz
sudo mkdir -p /usr/local/lib /usr/local/bin
# x.x の部分は変える
sudo mv heroku-cli-v6.x.x-darwin-64 /usr/local/lib/heroku
sudo ln -s /usr/local/lib/heroku/bin/heroku /usr/local/bin/heroku

#------------------------------------#
# vim dein
#------------------------------------#
mkdir ~/.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.vim
rm installer.sh


#------------------------------------#
# python
#------------------------------------#
sudo dnf install -y python-tools ctags
sudo python3 -m pip install -U pip
sudo pip3 install \
	pystan \
	numpy \
	scipy \
	matplotlib \
	ipython \
	jupyter \
	scikit-learn \
	pandas \
	pillow \
	beautiful-soup \
	html5lib \
	seaborn \
	scrapy \

# jupyter vimバインディング
sudo pip3 install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
mkdir -p $(jupyter --data-dir)/nbextensions

#------------------------------------#
# docker
#------------------------------------#
sudo dnf install -y docker-engine
sudo systemctl start docker
#dockerグループはすでにあるはずだけど念の為
sudo groupadd docker
#現在のユーザーをdockerグループに入れる
sudo usermod -aG docker $USER
sudo systemctl enable docker

#------------------------------------#
# firefox-beta
# 上部タブを隠す
#
# vim Profiles/<ランダム文字>.default/chrome/userChrome.css
# #tabbrowser-tabs { visibility: collapse !important; }
#------------------------------------#


# zshを設定
chsh -s /usr/bin/zsh

#------------------------------------#
# heroku
#------------------------------------#
npm install -g heroku-cli
