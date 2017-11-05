{-# OPTIONS -fno-warn-missing-signatures #-}

import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Monitor
{- import XMonad.Hooks.UrgencyHook (UrgencyHook, urgencyHook, withUrgencyHook) -}
import KeysMouseBindings
import Layout
import LogHook
import ManageHook
import StartupHook

import qualified DBus as D
import qualified DBus.Client as D.Client

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
    , manageHook              = myManageHook <+> manageMonitor vlcPiP
    , focusFollowsMouse       = myFocusFollowsMouse
    , clickJustFocuses        = myClickJustFocuses
    , handleEventHook         = docksEventHook              -- Whenever a new dock appears, refresh the layout immediately to avoid the new dock
  }
