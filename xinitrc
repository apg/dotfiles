xmodmap ~/.xmodmaprc

if [ -e ~/.Xdefaults ]; then
   xrdb -merge ~/.Xdefaults
fi

trayer --edge top --align right --SetDockType true --SetPartialStrut true \
 --expand true --width 10 --transparent true --tint 0x000000 --height 12 &

#xscreensaver -no-splash &

xsetroot -solid midnightblue
xsetroot -cursor_name left_ptr

feh --bg-center ~/Pictures/wave_1366.jpg

if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi

if [ -x /usr/bin/xfce4-power-manager ]; then
   sleep 3
   xfce4-power-manager
fi

while true; do
    sh ~/.dwm.sh
    sleep 1
done | ~/bin/dwm

