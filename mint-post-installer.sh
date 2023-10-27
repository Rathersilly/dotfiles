#!/bin/bash
# exit status is $?
check_status() {
	if [ $? = 1 ]; then
		echo "$1 checksum failed"
		exit 1
	else
		echo "$1 checksum passed!"
		echo "good job!"
	fi
}

# nvim_filename="nvim-linux64.deb"
# nvim_version="v0.7.0"
username="rsil"
email="rathersilly@live.com"
todo="setup git ssh"

# #cd ~/Downloads
# echo "--- Downloading $nvim_filename $nvim_version"
# curl https://github.com/neovim/neovim/releases/download/$nvim_version/$nvim_filename -L -o $nvim_filename
# curl https://github.com/neovim/neovim/releases/download/$nvim_version/$nvim_filename.sha256sum -L -o $nvim_filename.sha256sum
# cat $nvim_filename.sha256sum | sha256sum --check # --status
# check_status $nvim_filename

#sudo dpkg -i $nvim_filename

cd ~
#git clone https://github.com/Rathersilly/dotfiles.git
echo "--- Setting git defaults"
git config --global user.name $username
git config --global user.email $email
git config --global init.defaultBranch main
git config --global color.ui auto
git config --get user.name
git config --get user.email
git config -l
# echo "--- Making neovim dotfile symlinks"
# mkdir -p ~/.config/nvim
# ln -s ~/dotfiles/init.lua ~/.config/nvim/init.lua
# ln -s ~/dotfiles/lua ~/.config/nvim/lua

# more nvim stuff
# seeing is believing

#setup git ssh
#ssh-keygen -t ed25519 -C $email
# create todo string to add to end

#do bashrc stuff
mv ~/.bashrc ~/.bashrc.bak
# ln -s ~/dotfiles/.bashrc ~/.bashrc

# do ruby stuff
# see odin project maybe, rather than using this
# https://www.theodinproject.com/lessons/ruby-installing-ruby
# sudo apt install gcc make libssl-dev libreadline-dev zlib1g-dev libsqlite3-dev build-essential
# git clone https://github.com/rbenv/rbenv.git ~/.rbenv
# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
# echo 'eval "$(rbenv init -)"' >> ~/.bashrc
# exit
# mkdir -p "$(rbenv root)"/plugins
# git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
# rbenv -v
# rbenv install 3.1.2 --verbose
# rbenv global 3.1.2
# ruby -v

# gems
# pry rspec colorize rails

#download nerd fonts
# rather than hard link it, can get from here: https://www.nerdfonts.com/font-downloads
# in mint, can go to preferences->appearance->fonts and add new font there

# additional repositories?

# additional programs?
# gimp git-cola
# gimp alternatives: photopea (online), kolourpaint
# silversearcher-ag
# rg
# valgrind
# parcellite # clipboard manager

# to use g++ (added it earlier, when installing ruby)
# rails also needs node installed
#apt install build-essential nodejs

# additional instructions if this is vm

# misc
rmdir Templates Public Videos

echo "\n"
echo "You still need to do these things:"
echo $todo
