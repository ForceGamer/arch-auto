# Automatic setup of my preferred WM, DM, themes, and some extras
# This file assumes that you are root

#-------------
#LightDM setup
#-------------
pacman --no-confirm -Sy git xorg-server lightdm lightdm-webkit-greeter
cd /usr/share/lightdm-webkit/themes/
git clone https://github.com/GabrielTenma/lightdm-gab-gradient
