#!/bin/sh
systemctl --user import-environment DISPLAY


# networkmanager-applet
if [ -x /usr/bin/nm-applet ] ; then
  nm-applet --sm-disable &
fi

# pulseaudio-tray
if [ -x /bin/pasystray ] ; then
  pasystray &
fi

if [ -x /usr/bin/urxvtd ] ; then
  urxvtd -q -o -f &
fi

if [ -x /usr/bin/unclutter ] ; then
  unclutter --timeout 1 --fork
fi

if [ -x /usr/bin/gnome-keyring-daemon ] ; then
  eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
fi

# starting xautolock
if [ -x /usr/bin/xautolock ] ; then
        xautolock -time 5 -locker "xset dpms force off & slock" -notify 60 -notifier "notif
y-send 'Locking in 1 Minute'" -corners ---- &
fi

# starting redshift
if [ -x /usr/bin/redshift-gtk ] ; then
        redshift-gtk &
fi

if [ $comands[fbsetroot] ] ; then
        fbsetroot -solid '#282a36'
fi

# set up an icon tray
#if [ -x /usr/bin/trayer ] ; then
#  trayer --edge top --align right \
#         --monitor primary \
#         --width 20 --height 17 \
#         --transparent true --alpha 0 \
#	 --tint 0x282a3600 \
#         --expand true &
#fi

if [ -x /bin/stalonetray ] ; then
	stalonetray &
fi


xinput disable 12
exec xmonad
