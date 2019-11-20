#!/bin/sh
systemctl --user import-environment DISPLAY


# networkmanager-applet
if [ -x /usr/bin/nm-applet ] ; then
  nm-applet --sm-disable &
fi

# pulseaudio-tray
if [ -x /bin/pasystray ] ; then
#  pasystray &
  pa-applet &
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

if [ $comands[blueberry-tray] ] ; then
  blueberry-tray &
fi

#set up an icon tray
if [ -x /usr/bin/trayer ] ; then
  trayer --edge top --align right \
    --monitor primary \
    --width 7 --height 17 \
    --transparent true --alpha 0 \
    --tint 0x00282a36 \
    --expand true &
fi

xinput disable 12
exec /home/samuele/.cabal/bin/xmonad
