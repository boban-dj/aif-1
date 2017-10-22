#!/bin/bash

# The backup directory, BK is created automatically
# It tars (compresses) the BK folder, names it hostname-date.tar.gz
# You can edit the filepaths below, or make a file backup_files

# Usage sudo ./copy_config

touch ./backup_files
cat <<EOT >> backup_files
/etc/httpd/conf
/etc/makepkg.conf
/etc/pacman.d/mirrorlist
/etc/php/php.ini
/etc/mysql/my.cnf
/etc/ssh/sshd_config
/etc/default/grub
/boot/grub/themes
/etc/fstab
/etc/X11
/home/boban/.config/xfce4
/home/boban/.config/Thunar
/home/boban/Scripts    
/home/boban/.bash_profile
/home/boban/.bash_history
/home/boban/.bashrc
/home/boban/.dir_colors
/home/boban/.dir_colors_256
/home/boban/.i3
/home/boban/.i3status.conf
/home/boban/.nanorc
/home/boban/Packages_pacman-Qqe
/home/boban/Packages_pacman-Qqm.aur
/home/boban/Packages_pacaur-Qm.aur
/home/boban/Packages_pacaur-Qn.aur
/home/boban/Scripts
/home/boban/.xinitrc
/home/boban/.Xresources
/home/boban/.Xresources.d
/home/boban/.gimp-2.8
/home/boban/.config/geany
/home/boban/.cache/sessions
/home/boban/.nanorc
/home/boban/.bluefish
/usr/share/mc/skins
/home/boban/.config/mc
EOT



# List pacman and AUR installs for easy install
# Install all listed like this: 
# sudo xargs -a Packages pacman -S --noconfirm --needed
pacman -Qqe | grep -vx "$(pacman -Qqm)" > /home/boban/Packages_pacman-Qqe
pacman -Qqm > /home/boban/Packages_pacman-Qqm.aur


# List PACAUR AUR -m --foreign and -n --native installs
pacaur -Qm > /home/boban/Packages_pacaur-Qm.aur
pacaur -Qn > /home/boban/Packages_pacaur-Qn.aur

# list installed fonts
#fc-list | sort > fonts_installed.txt



# reading the file backup_files
if [[ $1 == "-l" ]]
then
for i in $(cat ./backup_files)
do
echo $i
done
exit
fi

#if [[ $1 == "-h" ]]
#then
#echo "cb (Config Backup) version 0.1a"
#echo "Usage: cb -[lhr]"
#echo "-l    Don't copy anything, just display the config file"
#echo "-h    Show this help/version"
#echo "-r   Restore files"
#exit
#fi

if [[ $1 == "-r" ]]
then
echo "Putting configs in your home directory,"
echo "you should find them there"
cp -a ./BK/* .
exit
fi

if [ -a ./backup_files ]
then
echo "Starting cb backup process..."
echo "-----------------------------"
else
touch ./backup_files
fi

if [ -d ./BK ]
then
echo "Backing up my own config file..."
cp -a ./backup_files ./BK/backup_files
else
mkdir -p ./BK
fi

for i in $(cat ./backup_files)
do
echo "Backing up" $i"..."
cp -a $i ./BK
done

echo "----------------"
echo "Done backing up."



## make tar from backup files in BK

backup_files=./BK

# Destination of Backup.
dest="."

# Create archive filename.
day=$(date +%Y-%m-%d)
hostname=$(hostname -s)
archive_file="$hostname-$day.tar.gz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

# Backup The Files using tar.
tar -zcvf $dest/BK/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# cleanup
rm -r ./backup_files

# Long listing of files in $dest to check file sizes.
#ls -lh ./BK
tree -L 1 ./BK
