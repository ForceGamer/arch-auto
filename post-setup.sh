# Automatic setup of my preferred WM, DM, themes, and some extras
USER=$(whoami)

#---------
#YAY setup
#---------
sudo pacman --noconfirm -Sy git
sudo mkdir /temp
sudo chown $USER:$USER /temp
cd /temp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~
rm -rf /temp/*
clear

#-------------
#LightDM setup
#-------------
sudo pacman --noconfirm -S xorg-server lightdm lightdm-webkit2-greeter
cd /usr/share/lightdm-webkit/themes/
sudo git clone https://github.com/GabrielTenma/lightdm-gab-gradient
echo "Manual intervention required. Instructions:"
echo "Change webkit_theme to: lightdm-gab-gradient"
read -p "Enter editor to use: " editor
sudo pacman -S $editor
sudo $editor /etc/lightdm/lightdm-webkit2-greeter.conf
echo "Manual intervention required. Instructions:"
echo "Under [Seat:*], uncomment #greeter-session=, and change its value to lightdm-webkit2-greeter"
read -p "Press enter to continue"
sudo $editor /etc/lightdm/lightdm.conf
clear

#-----
#Fonts (required for lightdm theme, and some Office docs)
#-----
yay -S --noconfirm ttf-iosevka ttf-windows
