{-# OPTIONS -fno-warn-missing-signatures -ilib #-}

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks

import KeysMouseBindings
import Layout
import LogHook
import ManageHook
import StartupHook

import qualified DBus as D
import qualified DBus.Client as D.Client

main :: IO ()
main = do
  dbusLine <- connectDBusClient -- connect to dbus to interface with statusbars and pass on the connection to LogHook
  xmonad $ ewmh $ myConfig dbusLine

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
