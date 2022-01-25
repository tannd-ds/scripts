#!/bin/sh

cd ~
mkdir removeLater

# gnome-tweak-tool
echo -e "\033[0;32mInstalling Tweaks...\033[0;37m"
sudo add-apt-repository universe
sudo apt install gnome-tweak-tool
sudo apt install gnome-shell-extensions


# Helper
echo -e "\033[0;32mInstalling wget...\033[0;37m"
sudo apt-get install wget
echo -e "\033[0;32mInstalling curl...\033[0;37m"
sudo apt install curl
echo -e "\033[0;32mInstalling snap...\033[0;37m"
sudo apt install snap
echo -e "\033[0;32mInstalling git...\033[0;37m"
sudo apt install git
echo -e "\033[0;32mInstalling yarn...\033[0;37m"
sudo apt install yarn
echo -e "\033[0;32mInstalling Nodejs...\033[0;37m"
cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs
rm nodesource_setup.sh

## ----- MAKE SYMBOLIC LINK FOR CONFIGURATION FILES -----
git clone https://github.com/tannd-ds/dotfiles.git ~/dotfiles/
echo -e "\033[0;32mCreating Symbolic links for Config files...\033[0;37m"
# in ~/ folder
rm ~/.bashrc
for file in ~/dotfiles/home/.*; do
	ln -sf ${file} ~/
done

# in ~/.config folder
if [ -d ~/.config ]
then
	echo "\033[0:33m.config exists in home directory...\033[0;37m"
	ln -sf ~/dotfiles/.config/* ~/.config/
else
	echo "\033[0:33m.config doesn't exist, create one...\033[0;37m"
	ln -sf ~/dotfiles/.config ~/
fi

# Alacrity - Terminal Emulator
echo -e "\033[0;32mInstalling Alacritty...\033[0;37m"
sudo snap install alacritty --classic

# Python
echo -e "\033[0;32mInstalling Python...\033[0;37m"
sudo apt-get install python3 python3-venv python3-pip pip
sudo pip install jupyter

# MS Teams
echo -e "\033[0;32mInstalling MS Teams...\033[0;37m"
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB3E94ADBE1229CF
sudo apt update
sudo apt install teams

echo "\033[0;32mDo you want to install nVim Essential? [Y]/n?\033[0;37m"
read ACCEPT
if [ "$ACCEPT" = 'Y' ] || [ "$ACCEPT" = 'y' ] || [ "$ACCEPT" = '' ]
then
	./nvim-essential
else
	echo "\033[0;31mCancled installing nVim Essential...\033[0;37m"
fi

# install Orchis Theme
echo -e "\033[0;32mInstalling Orchis Themes...\033[0;37m"
cd ~/removeLater
git clone https://github.com/vinceliuice/Orchis-theme orchis-theme
cd orchis-theme
./install.sh -t grey

# install Powerline font (for vim statusline)
echo -e "\033[0;32mInstalling Powerline Fonts...\033[0;37m"
cd ~/removeLater
git clone https://github.com/powerline/fonts powerline-fonts
cd powerline-fonts
./install.sh

# Install Chrome
echo -e "\033[0;32mInstalling Chrome...\033[0;37m"
cd ~/removeLater
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

cd ~/removeLater
git clone https://gitlab.gnome.org/GNOME/gnome-shell-extensions gnome-shell-extensions
mv gnome-shell-extensions/extensions/user-theme/ ~/.local/share/gnome-shell/

# Download Wallpaper
wget -O ~/Pictures/astronaut-wallpaper.jpg "https://docs.google.com/uc?export=download&id=19Wrrlz9RO2x9m34xGwgrOF8RGDtCfCU8"

# Remove unused files (~/removeLater)
rm -r ~/removeLater

# Markdown packages
sudo apt install pandoc zathura
sudo apt install texlive-latex-extra
sudo apt-get install texlive-xetex # Required for Unicode Text (wrote in Vietnamese)

echo "\033[0;32mTo Change Theme, open Tweaks -> Extensions and enable 'User themes'\033[0;37m"
echo "\033[0;32mTo change Wallpaper, direct to ~/Pictures/\033[0;37m"
