module StartupHook where

import XMonad
import XMonad.Hooks.SetWMName

-- | Perform arbitrary actions at xmonad startup.
myStartupHook :: X ()
myStartupHook =
  setWMName "LG3d" >> spawn "/usr/bin/nm-applet" >>
  spawn "/usr/bin/redshift-gtk"
