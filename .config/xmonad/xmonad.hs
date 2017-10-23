{-# OPTIONS -fno-warn-missing-signatures #-}

import           XMonad
import           XMonad.Hooks.EwmhDesktops        (ewmh)
import           XMonad.Hooks.ManageDocks

import           XMonad.Custom.KeysMouseBindings
import           XMonad.Custom.Layout
import           XMonad.Custom.LogHook
import           XMonad.Custom.ManageHook
import           XMonad.Custom.StartupHook

main :: IO ()
main =
    xmonad $ ewmh $ docks myConfig  -- Add docks functionality to the given config

myConfig = def
  { borderWidth               = myBorderWidth
    , workspaces              = myWorkspaces
    , layoutHook              = avoidStruts myLayout          -- Adjust layout automagically to no voer up any dock, status bars, etc...
    , terminal                = myTerminal
    , normalBorderColor       = myNormalBorderColor
    , focusedBorderColor      = myFocusedBorderColor
    , modMask                 = myDefaultModMask
    , keys                    = myKeys
    , logHook                 = myLogHook
    , startupHook             = myStartupHook
    , mouseBindings           = myMouseBindings
    , manageHook              = myManageHook
    , focusFollowsMouse       = myFocusFollowsMouse
    , clickJustFocuses        = myClickJustFocuses
    , handleEventHook         = docksEventHook              -- Whenever a new dock appears, refresh the layout immediately to avoid the new dock
  }
