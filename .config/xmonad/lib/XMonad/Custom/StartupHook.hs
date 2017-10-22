module XMonad.Custom.StartupHook where

import           XMonad
import           XMonad.Hooks.SetWMName


	-- | Perform arbitrary actions at xmonad startup.
startupHook :: X ()
startupHook = setWMName "LG3d"
	          >> spawn "/usr/bin/nm-applet"
		        >> spawn "/usr/bin/redshift-gtk"
