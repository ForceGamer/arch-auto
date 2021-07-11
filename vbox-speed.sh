#Script 1
echo "Welcome to Arch Linux Magic Script"
echo "Credits: BugsWriter"
pacman --noconfirm -Sy archlinux-keyring
echo "Keymap: "
read keymap
loadkeys $keymap
timedatectl set-ntp true
cfdisk /dev/sda
mkfs.ext4 /dev/sda2
mkfs.vfat -F 32 /dev/sda1

mount /dev/sda2 /mnt 
pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

sed '1,/^#part2$/d' vbox-speed.sh > /mnt/vbox-speed2.sh
chmod +x /mnt/arch_install2.sh
arch-chroot /mnt ./vbox-speed2.sh
exit 

#part2
echo "Keymap: "
read keymap
localectl set-keymap $keymap
time=Europe/Berlin
ln -sf /usr/share/zoneinfo/$time /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=$keymap" > /etc/vconsole.conf
echo "Hostname: "
read hostname
echo $hostname > /etc/hostname
echo "127.0.0.1       localhost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts
echo "127.0.1.1       $hostname.localdomain $hostname" >> /etc/hosts
mkinitcpio -P
passwd
pacman --noconfirm -S grub 
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg
pacman --noconfirm -S dhcpcd networkmanager 
systemctl enable NetworkManager.service 
pacman --noconfirm -S virtualbox-guest-utils
rm /arch_install2.sh

#visudo
#echo "Enter Username: "
#read username
#useradd -m -G wheel -s /bin/bash $username
#passwd $username
#echo "Pre-Installation Finish Reboot now"
reboot
