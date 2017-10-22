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



- todo: display driver => display server => wm manager: cursor gaat niet vanzelf op de goed plaats staan?
- todo: Install Network Capabilities: Install Cups/Printer Packages + SAMBA toevoegen
- todo: Install Multimedia Support: gstreamer CHECK
- todo: Custom packages?
- todo: make copy aif-master in final ${MOUNTPOINT} 


## After install, in your new Archlinux installation:

- run `pacman -Syy && pacman -S git --noconfirm`, run `# trust extract-compat`
- install as USER (not ROOT): `./pacaur_install.sh`
- vbox-guest for LTS kernel: `pacman -S virtualbox-guest-utils xorg-xinit virtualbox-guest-utils virtualbox-guest-dkms`
- `GRUB_CMDLINE_LINUX_DEFAULT="quiet video=1360x768"`
- or vbox resolution: `/etc/default/grub`: `GRUB_GFXMODE="1360x768x24"` 
- regenerate grub.cfg: `sudo grub-mkconfig -o /boot/grub/grub.cfg`


## install notes VBOX:

- for vbox install archlinux guide: <http://www.cs.columbia.edu/~jae/4118-LAST/arch-setup-2016-1.html>


## TODO Z800: After install `aif.sh` script

- add sharedfuncs from aui: nginx,apache,mariadb,sudoers,etc
- add multilib repo: in /etc/pacman.conf uncomment, then upgrade: pacman -Syu
	
	[multilib]
	Include = /etc/pacman.d/mirrorlist

- add user: printadmin (cups),vboxusers (vbox), uucp (android)

	tty lp wheel uucp http lock users vboxusers docker wireshark adbusers autologin printadmin sdkusers

- all programs: xargs -a Packages pacaur -S --noconfirm --needed
- all programs: xargs -a Packages.AUR pacaur -S --noconfirm --needed
- android, gimp plugins
- xfce4 + i3 session
- check /etc/hosts file
- grub: `/etc/default/grub`: `GRUB_DISABLE_SUBMENU=y`
- grub theme: `/etc/default/grub` : `GRUB_THEME="/boot/grub/themes/Archxion/theme.txt"`
- blacklist beep: 
		echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf
		rmmod pcspkr



## SOLVED

- xfce4 icons missing
- video? in Xorg log there was a complaint about fbdev and vesa, so installed
	`sudo pacman -S xf86-video-vesa`
	`sudo pacman -S virtualbox-guest-utils virtualbox-guest-iso virtualbox-guest-dkms linux-lts-headers`
- install `pacman -S openssh`, `systemctl enable sshd`, `systemctl start sshd`
- when in ssh shell: `export TERM=xterm` (term is giving problems in ssh shell)
- Copied all BK to new system, installed and everythings seems fine
		
		pacaur -S i3(all) xorg-xprop dmenu2 j4-dmenu-desktop-git urxvt-perls rxvt-unicode-patched urxvt-tabbedex-git



