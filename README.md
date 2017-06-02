# aif-master

WORK in PROGRESS.

Run an official Archlinux iso, inside root:
git clone the repo in /
then run ./aif.sh and follow the instructions

SIMPLE: partitions and low level setup

BEFORE:

- run pacman -Syy && pacman -S git --noconfirm, run # trust extract-compat
- install pacaur_install.sh, git clone aif-master
- run aif-master/aif.sh, RENAME in script correctly after unzipping/cloning
- SCRIPT:make copy aif-master in final ${MOUNTPOINT} 
- check /etc/hosts file
- grub: GRUB_DISABLE_SUBMENU=y
- grub theme:GRUB_THEME="/boot/grub/themes/Archxion/theme.txt"
- vbox resolution:/etc/default/grub: GRUB_GFXMODE="1360x768x24" (regenerate grub.cfg)
- add sharedfuncs from aui: nginx,apache,mariadb,sudoers,etc


AFTER:

- all BK config files
- function for pacaur install (see script)
- add BK with config files
- xfce4 + i3 session
- xargs -a Packages pacaur -S --noconfirm --needed
- xargs -a Packages.AUR pacaur -S --noconfirm --needed
- add multilib repo:
in /etc/pacman.conf uncomment, then upgrade: pacman -Syu
	
	[multilib]
	Include = /etc/pacman.d/mirrorlist

- android, gimp plugins
- add user: printadmin (cups),vboxusers (vbox), uucp (android)
	tty lp wheel uucp http lock users vboxusers docker wireshark adbusers autologin printadmin sdkusers



Notes:
- Wireless not working: must install wicd-gtk python2-notify
- problems wireless

		Apr 11 20:37:28 arch2570 kernel: kvm: disabled by bios
		Apr 11 20:37:28 arch2570 kernel: b43-phy0 ERROR: Firmware file "b43/ucode30_mimo.fw" not found
		Apr 11 20:37:28 arch2570 kernel: b43-phy0 ERROR: Firmware file "b43-open/ucode30_mimo.fw" not found
		Apr 11 20:37:28 arch2570 kernel: b43-phy0 ERROR: You must go to http://wireless.kernel.org/en/users/Driv
		Apr 11 20:47:29 arch2570 systemd[1]: Failed to start Wicd a wireless and wired network manager for Linux
		Apr 11 20:49:05 arch2570 systemd[1]: Failed to start Wicd a wireless and wired network manager for Linux

- pacaur -S b43-firmware

- blacklist beep: 
		echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
		rmmod pcspkr
- grub themes not working: typo: theme/txt vs theme.txt
- login strange? -enable in bios VK virtual machines

