/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

# make CapsLock behave like Ctrl:
setxkbmap -option ctrl:nocaps

# make short-pressed Ctrl behave like Escape:
xcape -e 'Control_L=Escape'
compton --config $HOME/.config/compton.conf -b

exec xmonad
