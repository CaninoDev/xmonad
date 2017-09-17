module XMonad.Custom.StartupHook where

import           XMonad
-- | Perform an arbitrary action at xmonad startup.
startupHook :: X ()
startupHook = spawn "/home/caninodev/.local/bin/backlight"

