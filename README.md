# aif-master

!WORK in PROGRESS.

Run an official Archlinux iso, inside root: git clone the repo in /
then run ./aif.sh and follow the instructions

## Archlinux iso + aif.sh script

- start from Archlinux iso
- run `pacman -Syy && pacman -S git --noconfirm`, run `# trust extract-compat`
- `git clone https://github.com/boban-dj/aif-master`
- run `aif-master/aif.sh`
- follow instructions

## review config files

- `GRUB_CMDLINE_LINUX_DEFAULT="quiet video=1360x768"`
- or vbox resolution: `/etc/default/grub`: `GRUB_GFXMODE="1360x768x24"` 
- grub: `/etc/default/grub`: `GRUB_DISABLE_SUBMENU=y`
- grub theme: `/etc/default/grub` : `GRUB_THEME="/boot/grub/themes/Archxion/theme.txt"`
- regenerate grub.cfg: `sudo grub-mkconfig -o /boot/grub/grub.cfg`

## TODO aif.sh

- !! todo: make copy aif-master in final ${MOUNTPOINT}: cp -r aif-master /?? (for now clone from github)
- !! TODO: display driver => display server => wm manager: in aif.sh dialog, cursor gaat niet vanzelf op de goed plaats staan?
- !! VBOX video? in Xorg log there was a complaint about fbdev and vesa: `pacman -S xf86-video-fbdev xf86-video-vesa`
- !! VBOX `startx` : `# modprobe -a vboxguest vboxsf vboxvideo` and enable on startup: `systemctl enable vboxservice.service`
- Wicd gui
- disable DHCPCD
- ?Install Cups/Printer Packages + SAMBA toevoegen
- ?Install Multimedia Support: gstreamer CHECK

## After install, in your new Archlinux installation:

- run `sudo pacman -Syy && sudo pacman -S git --noconfirm`, run `# trust extract-compat`
- install as USER (not ROOT): `./pacaur_install.sh`
- xargs -a Packages pacaur -S --noconfirm --needed
- xargs -a Packages.AUR pacaur -S --noconfirm --needed
- copy dotfiles `~`, and to `/root`
- i3 config and i3status change to reflect `enp0s3` or whatever.
- icons `i3status.conf`
- disable `dhcpcd` (wicd is the manager)

## GRUB

- grub desktop: `GRUB_CMDLINE_LINUX_DEFAULT="quiet video=1360x768"`
- vbox resolution: `/etc/default/grub`: `GRUB_GFXMODE="1360x768x24"` 
- grub: `/etc/default/grub`: `GRUB_DISABLE_SUBMENU=y`
- grub theme: `/etc/default/grub` : `GRUB_THEME="/boot/grub/themes/Archxion/theme.txt"`
- regenerate `grub.cfg`: `sudo grub-mkconfig -o /boot/grub/grub.cfg`

## install notes VBOX (Guest):
- vbox-guest for LTS kernel: `pacman -S virtualbox-guest-utils xorg-xinit virtualbox-guest-dkms`
- for vbox install archlinux guide: <http://www.cs.columbia.edu/~jae/4118-LAST/arch-setup-2016-1.html>
- <https://wiki.archlinux.org/index.php/VirtualBox#Installation_steps_for_Arch_Linux_guests>
- Enable Shared folder in `HOST`. (Vbox interface)
- In `GUEST` add `$USER` to group for Shared Folder:
the `virtualbox-guest-utils` package created a group `vboxsf`; your username must be in `vboxsf` group.
		
		sudo gpasswd -a boban vboxsf
		(or `sudo usermod -aG vboxsf boban`)??
		sudo chown -R boban:users media

logout-login to access /media/sf_Virtualbox_shared

## vbox GUEST services

- source <https://wiki.archlinux.org/index.php/VirtualBox#Launch_the_VirtualBox_guest_services>
- execute from terminal or add to .xinitrc, for shared clipboard etc
		
		VBoxClient-all

## Numlock on when startx.

		pacman -S numlockx 
		:in ~/.xinitrc add: `numlockx &`

## MYSQL

		pacman -S mariadb
		# mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
		# systemctl start mariadb.service
		# mysql_secure_installation
		
## PHP56

**php56 & php56-apache** I installed php56 first, nut no php56.so was installed. After php56-apache everything is OK.

**Install:**
add keys before installing php56 packages: mickael9 commented on 2016-04-06 11:51 <https://aur.archlinux.org/packages/php56/>

		gpg --keyserver hkp://hkps.pool.sks-keyservers.net --recv-keys C2BF0BC433CFC8B3 FE857D9A90D90EC1
		- pacaur -S php56 php56-apache php56-gd php56-mssql php56-tidy (and whatever needed)

In `/etc/php56/php.ini` uncomment mysqli.so, mysql.so, pdo_mysql, tidy.so extensions. (and whatever you need)

## PHP56-apache

Location configs php-56 (php56-apache): 

		Config : /etc/php56
		Extensions : /usr/lib/php56/modules
		Binaries : /usr/bin/php56, /usr/bin/php56-cgi, /usr/bin/phar56, etc.

The apache module is installed as libphp56.so, so you should use the following lines your httpd.conf :
	
		# Load php 5.6 module
		LoadModule php5_module modules/libphp56.so

In `/etc/httpd/conf/httpd.conf` comment:
		
		LoadModule mpm_event_module modules/mod_mpm_event.so

uncomment:

		LoadModule mpm_prefork_module modules/mod_mpm_prefork.so


## HTTP group setfacl

/srv/http group permissions
	
	# usermod -aG additional_groups username
	# usermod -aG http boban

setfacl:

		# chown -R root:http http
		# chmod g+s /srv/http

add $USER to the http group (logout and login to make the groups current)

	usermod -aG http boban

set the http dir with acl for group http recursive

	sudo setfacl -R -m group:http:rwx /srv/http

set the http dir with acl for group http recursive as default

	sudo setfacl -Rd -m group:http:rwx /srv/http

gefacl /srv/http to see result


## SSH

- install 

		pacman -S openssh
		systemctl enable sshd
		systemctl start sshd



*********************************************
## TODO Z800: After install `aif.sh` script
- dual session i3-xfce4
- add sharedfuncs from aui: nginx,apache,mariadb,sudoers,etc
- add multilib repo: in /etc/pacman.conf uncomment, then upgrade: pacman -Syu

	[multilib]
	Include = /etc/pacman.d/mirrorlist

- add groups to $USER: printadmin (cups),vboxusers (vbox), uucp (android)

	tty lp wheel uucp http lock users vboxusers docker wireshark adbusers autologin printadmin sdkusers

- configs programs: android, gimp plugins ,etc.
- xfce4 + i3 session
- grub: `/etc/default/grub`: `GRUB_DISABLE_SUBMENU=y`
- grub theme: `/etc/default/grub` : `GRUB_THEME="/boot/grub/themes/Archxion/theme.txt"`
- blacklist beep: 

		echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
		rmmod pcspkr



