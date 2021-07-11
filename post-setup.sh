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
#https://github.com/GabrielTenma/lightdm-gab-gradient | My theme of choice
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
read -p "$editor will be opened. Press enter"
sudo $editor /etc/lightdm/lightdm.conf
sudo systemctl enable lightdm
clear

#-----
#Fonts (required for lightdm theme, and some Office docs)
#-----
yay -S --noconfirm ttf-iosevka ttf-windows otf-ipafont

#-------------
#Openbox setup
#https://github.com/owl4ce/dotfiles | My theme of choice
#-------------
yay -S rsync python psmisc xorg-xprop xorg-xwininfo imagemagick ffmpeg wireless_tools openbox \
pulseaudio pulseaudio-alsa alsa-utils brightnessctl nitrogen dunst tint2 gsimplecal rofi \
qt5-styleplugins lxsession xautolock rxvt-unicode-truecolor-wide-glyphs xclip scrot thunar \
thunar-archive-plugin thunar-volman ffmpegthumbnailer tumbler viewnior mpv mpd mpc ncmpcpp \
pavucontrol parcellite neofetch w3m htop picom-git obmenu-generator gtk2-perl playerctl xsettingsd zsh
