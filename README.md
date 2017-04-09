# aif

Run an official Archlinux iso,
inside root:
git clone the repo in /
then run ./aif.sh and follow the instructions

bugs:

- dont run mkinitcpio, when installing grub it runs mkinitcpio
- check 2041 for vbox driver and modules
- OK:add user to vbox group
- check /etc/hosts file


todo:

- install os-prober
- add sharedfuncs from aui: nginx,apache,mariadb,sudoers, etc
- function for pacaur install (see script)
- run # trust extract-compat
- add BK with config files
- add pacman installed list
- add pacaur installed list

- review config files:

grub: GRUB_DISABLE_SUBMENU=y
.xinitrc: exec startxfce4
2036: add this GRUB_GFXMODE="1360x768x24"
