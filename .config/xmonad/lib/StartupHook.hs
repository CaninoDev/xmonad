module StartupHook where



import XMonad
import XMonad.Hooks.SetWMName


-- | Perform arbitrary actions at xmonad startup.
myStartupHook :: X ()
myStartupHook =
  setWMName "LG3d"
  >> spawn "redshift-gtk-restart"
  -- >> spawn "/usr/bin/nm-applet"
  >> spawn "compton -b --config /home/caninodev/.config/compton.conf"
  >> spawn "xsetroot -cursor_name left_ptr"
