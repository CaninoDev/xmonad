module XMonad.Custom.StartupHook where

import           XMonad
import           XMonad.Hooks.SetWMName


	-- | Perform an arbitrary action at xmonad startup.
startupHook :: X ()
startupHook = setWMName "LG3d"
            >> spawn "/home/caninodev/.local/bin/backlight"
	          >> spawn "/usr/bin/nm-applet"
		        >> spawn "/usr/bin/redshift-gtk"
