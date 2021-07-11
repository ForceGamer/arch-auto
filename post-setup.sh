# Automatic setup of my preferred WM, DM, themes, and some extras

#---------
#YAY setup
#---------
sudo pacman --noconfirm -Sy git
sudo mkdir /temp
sudo chown
cd /temp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~
rm -rf /temp/*


#-------------
#LightDM setup
#-------------
sudo pacman --noconfirm -S xorg-server lightdm lightdm-webkit-greeter
cd /usr/share/lightdm-webkit/themes/
git clone https://github.com/GabrielTenma/lightdm-gab-gradient
