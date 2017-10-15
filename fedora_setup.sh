#!/bin/sh

echo "Here we go"

# 管理者で入る
su

dnf update -y
dnf install -y \
	gimp \
	git \
	inkscape \
	openssh \
	rsync \

#------------------------------------#
# docker
#------------------------------------#
systemctl start docker
#dockerグループはすでにあるはずだけど念の為
groupadd docker
#現在のユーザーをdockerグループに入れる
usermod -aG docker $USER
sudo systemctl enable docker


#------------------------------------#
# vim
#------------------------------------#
cd /usr/src
git clone https://github.com/vim/vim.git
cd vim/src
./configure \
   --with-features=huge \
   --enable-gui=gnome3 \
   --enable-multibyte \
   --enable-perlinterp=dynamic \
   --enable-pythoninterp=dynamic \
   --enable-rubyinterp=dynamic \
   --enable-luainterp=dynamic \
   --with-lua-prefix=/usr \
   --with-luajit \
   --enable-gpm \
   --enable-cscope \
   --enable-fontset \
   --enable-fail-if-missing
make
sudo make install


#------------------------------------#
# python
#------------------------------------#
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
	seaborn

# jupyter vimバインディング
pip3 install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user
mkdir -p $(jupyter --data-dir)/nbextensions

# 管理者を出る
exit
