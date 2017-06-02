# aif-master

WORK in PROGRESS.

Run an official Archlinux iso, inside root: git clone the repo in /
then run ./aif.sh and follow the instructions

## Architect iso + aif.sh script

- start from arch boot iso
- run pacman -Syy && pacman -S git --noconfirm, run # trust extract-compat
- git clone https://github.com/boban-dj/aif-master
- run aif-master/aif.sh, RENAME in script correctly after unzipping/cloning
- languages in correct folder
- xorg-server-utils check
- display driver => display server => wm manager: cursor gaat niet vanzelf op de goed plaats staan?
- CHECK: xfce4
- CHECK: i3
- Install Network Capabilities: Install Cups/Printer Packages + SAMBA toevoegen
- Install Multimedia Support: gstreamer CHECK
- Custom packages?
- SCRIPT:make copy aif-master in final ${MOUNTPOINT} 
- script finished



## New system:

- run pacman -Syy && pacman -S git --noconfirm, run # trust extract-compat
- install as USER (not ROOT): pacaur_install.sh, git clone aif-master (function for pacaur install see script)
- vbox-guest for LTS kernel: pacman -S virtualbox-guest-utils xorg-xinit virtualbox-guest-utils virtualbox-guest-dkms
- linux-lts-headers for linux-lts
- GRUB_CMDLINE_LINUX_DEFAULT="quiet video=1360x768"
- or vbox resolution:/etc/default/grub: GRUB_GFXMODE="1360x768x24" (regenerate grub.cfg)
- # systemctl enable vboxservice.service 
- # modprobe -a vboxguest vboxsf vboxvideo or logout




## Extra NOTE: for vbox install archlinux guide: <http://www.cs.columbia.edu/~jae/4118-LAST/arch-setup-2016-1.html>




## After install

- add sharedfuncs from aui: nginx,apache,mariadb,sudoers,etc
- add multilib repo: in /etc/pacman.conf uncomment, then upgrade: pacman -Syu
	[multilib]
	Include = /etc/pacman.d/mirrorlist
- add user: printadmin (cups),vboxusers (vbox), uucp (android)
	tty lp wheel uucp http lock users vboxusers docker wireshark adbusers autologin printadmin sdkusers
- android, gimp plugins
- xfce4 + i3 session
- add BK with config files
- check /etc/hosts file
- xargs -a Packages pacaur -S --noconfirm --needed
- xargs -a Packages.AUR pacaur -S --noconfirm --needed
- grub: GRUB_DISABLE_SUBMENU=y
- grub theme:GRUB_THEME="/boot/grub/themes/Archxion/theme.txt"
- blacklist beep: 
		echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
		rmmod pcspkr



## Problems SOLVED

- xfce4 icons missing
video? in Xorg log there was a compailt about fbdev and vesa, so installed
- sudo pacman -S xf86-video-vesa
- sudo pacman -S virtualbox-guest-utils virtualbox-guest-iso virtualbox-guest-dkms linux-lts-headers
- install openssh, systemctl enable sshd, systemctl start sshd
- export TERM=xterm (temr is givng problems in ssh shell)

-SOLVED: ok finally copied all BK to new system, installed and everythings seems fine
		pacaur -S i3(all) xorg-xprop dmenu2 j4-dmenu-desktop-git urxvt-perls rxvt-unicode-patched urxvt-tabbedex-git


## Problems older install: todo?

- Wireless not working: must install wicd-gtk python2-notify
- problems wireless
		Apr 11 20:37:28 arch2570 kernel: kvm: disabled by bios
		Apr 11 20:37:28 arch2570 kernel: b43-phy0 ERROR: Firmware file "b43/ucode30_mimo.fw" not found
		Apr 11 20:37:28 arch2570 kernel: b43-phy0 ERROR: Firmware file "b43-open/ucode30_mimo.fw" not found
		Apr 11 20:37:28 arch2570 kernel: b43-phy0 ERROR: You must go to http://wireless.kernel.org/en/users/Driv
		Apr 11 20:47:29 arch2570 systemd[1]: Failed to start Wicd a wireless and wired network manager for Linux
		Apr 11 20:49:05 arch2570 systemd[1]: Failed to start Wicd a wireless and wired network manager for Linux

- pacaur -S b43-firmware




