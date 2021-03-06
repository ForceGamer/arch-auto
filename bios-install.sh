#Script 1
echo "Welcome to Arch Linux Magic Script"
echo "Credits: BugsWriter"
pacman --noconfirm -Sy archlinux-keyring
echo "Keymap: "
read keymap
loadkeys $keymap
timedatectl set-ntp true
clear
lsblk
echo "Enter the drive: "
read drive
cfdisk $drive 
echo "Enter the linux partition: "
read partition
mkfs.ext4 $partition 
echo "Enter boot partition: "
read efipartition
mkfs.vfat -F 32 $efipartition

mount $partition /mnt 
pacstrap /mnt base base-devel linux-zen linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab

sed '1,/^#part2$/d' bios-install.sh > /mnt/mbr-install2.sh
chmod +x /mnt/mbr-install2.sh
arch-chroot /mnt ./mbr-install2.sh
exit 

#part2
echo "Keymap: "
read keymap
echo "Time [Region/City]: "
read time
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
echo "Enter drive (not partition): "
read drive
grub-install --target=i386-pc $drive
grub-mkconfig -o /boot/grub/grub.cfg
pacman --noconfirm -S dhcpcd networkmanager 
systemctl enable NetworkManager.service 
rm /mbr-install2.sh

visudo
echo "Enter Username: "
read username
useradd -m -G wheel -s /bin/bash $username
passwd $username
echo "Pre-Installation Finish Reboot now"
