{-# OPTIONS -fno-warn-missing-signatures -ilib #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks

import qualified DBus as D
import qualified DBus.Client as D

import KeysMouseBindings (myClickJustFocuses, myDefaultModMask, myFocusFollowsMouse, myKeys, myMouseBindings, myTerminal)
import Layout (myFocusedBorderColor, myBorderWidth, myLayout, myNormalBorderColor,
        myWorkspaces)
import LogHook (dBusInterface, dBusMember, dBusPath, myPolybar)
import ManageHook (myManageHook)
import StartupHook (myStartupHook)


main :: IO ()
main = do
  dbusLine <- D.connectSession
  D.requestName dbusLine (D.busName_ "org.xmonad.Log")
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
  , logHook = dynamicLogWithPP (myPolybar dbusLine)
  , startupHook = myStartupHook
  , mouseBindings = myMouseBindings
  , manageHook = myManageHook
  , focusFollowsMouse = myFocusFollowsMouse
  , clickJustFocuses = myClickJustFocuses
  , handleEventHook = docksEventHook -- Whenever a new dock appears, refresh the layout immediately to avoid the new dock
  }
