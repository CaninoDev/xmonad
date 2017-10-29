module StartupHook where


import XMonad
import XMonad.Hooks.SetWMName
import XMonad.Util.SpawnOnce

-- | Perform arbitrary actions at xmonad startup.
myStartupHook :: X ()
myStartupHook =
  spawn "redshift-gtk-restart"
  >> setWMName "LG3d"
  >> spawn "/usr/bin/nm-applet"
  >> spawn "polybar-restart"
  >> spawn "xsetroot -cursor_name left_ptr"
