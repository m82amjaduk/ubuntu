#!/bin/bash
NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)

red() {
	echo -e -n "$RED$*$NORMAL"
}
green() {
	echo -e -n "$GREEN$*$NORMAL"
}
yellow() {
	echo -e -n "$YELLOW$*$NORMAL"
}

#setup Vim
configure_vim() {
	if [ -f ~/.vimrc ]
	then
		mv ~/.vimrc ~/.vimrc.bak
		wget https://raw.github.com/JohnRCrawford/devEnvironment/master/config/vim/.vimrc ~/
		green "Made a back up of the pervious vim config file at: ~/.vimrc.bak \n"
	else
		wget https://raw.github.com/JohnRCrawford/devEnvironment/master/config/vim/.vimrc
	fi
}

#setup Zsh
configure_zsh() {
	#install Oh-my-zsh. A community-driven framework for managing your zsh configuration
	wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh
	yellow "If promted for password, please enter the password for the user: "
	whoami
	chsh -s `which zsh`
	if [ -f ~/.zshrc ]
	then
		mv ~/.zshrc ~/.zshrc.bak		
		wget https://raw.github.com/JohnRCrawford/devEnvironment/master/config/zsh/.zshrc ~/
		green "Made a back up of the pervious Zsh config file at: ~/.zshrc.bak \n"
	else
		wget https://raw.github.com/JohnRCrawford/devEnvironment/master/config/zsh/.zshrc ~/
	fi
}

while true; do
    read -p "Use John's Vim default config file? " yn
    case $yn in
        [Yy]* ) configure_vim; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
    read -p "Use John's Zsh default config file? " yn
    case $yn in
        [Yy]* ) configure_zsh; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
