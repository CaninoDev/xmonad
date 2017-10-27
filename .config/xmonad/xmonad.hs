{-# OPTIONS -fno-warn-missing-signatures -ilib #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks

import KeysMouseBindings
       (myDefaultModMask, myFocusFollowsMouse, myKeys, myMouseBindings, myTerminal)
import Layout
       (myBorderWidth, myLayout, myNormalBorderColor,
        myWorkspaces)
import LogHook (dBusInterface, dBusMember, dBusPath, myLogHook)
import ManageHook (myManageHook)
import StartupHook (myStartupHook)

import qualified DBus as D

main :: IO ()
main = do
  dbusLine <- D.connectSession
  D.requestName dbusLine (D.busName_ dBusInterface)
  [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]
  xmonad . ewmh $ myConfig dbusLine

myConfig dbusLine =
  def
  { borderWidth = myBorderWidth
  , workspaces = myWorkspaces
  , layoutHook = avoidStruts myLayout -- Adjust layout automagically to no cover up any dock, status bars, etc...
  , terminal = myTerminal
  , normalBorderColor = myNormalBorderColor
  , focusedBorderColor = myFocusedBorderColor
  , modMask = myDefaultModMask
  , keys = myKeys
  , logHook = myLogHook dbusLine
  , startupHook = myStartupHook
  , mouseBindings = myMouseBindings
  , manageHook = myManageHook
  , focusFollowsMouse = myFocusFollowsMouse
  , clickJustFocuses = myClickJustFocuses
  , handleEventHook = docksEventHook -- Whenever a new dock appears, refresh the layout immediately to avoid the new dock
  }
