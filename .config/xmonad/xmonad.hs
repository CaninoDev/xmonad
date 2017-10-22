{-# OPTIONS -fno-warn-missing-signatures #-}

import           XMonad
import           XMonad.Hooks.EwmhDesktops        (ewmh)
import           XMonad.Hooks.ManageDocks

import           XMonad.Custom.KeysMouseBindings
import           XMonad.Custom.Layout
import           XMonad.Custom.LogHook            as LG
import           XMonad.Custom.ManageHook         as M
import           XMonad.Custom.StartupHook        as ST

main :: IO ()
main = do
    xmonad $ ewmh $ docks myConfig  -- Add docks functionality to the given config

myConfig = def
  { XMonad.borderWidth        = myBorderWidth
  , XMonad.workspaces         = myWorkspaces
  , XMonad.layoutHook         = avoidStruts layout          -- Adjust layout automagically to no voer up any dock, status bars, etc...
  , XMonad.terminal           = myTerminal
  , XMonad.normalBorderColor  = myNormalBorderColor
  , XMonad.focusedBorderColor = myFocusedBorderColor
  , XMonad.modMask            = myDefaultModMask
  , XMonad.keys               = myKeys
  , XMonad.logHook            = LG.logHook
  , XMonad.startupHook        = ST.startupHook
  , XMonad.mouseBindings      = myMouseBindings
  , XMonad.manageHook         = M.manageHook
  , XMonad.focusFollowsMouse  = myFocusFollowsMouse
  , XMonad.clickJustFocuses   = myClickJustFocuses
  , XMonad.handleEventHook    = docksEventHook              -- Whenever a new dock appears, refresh the layout immeidately to avoid the new dock
}
