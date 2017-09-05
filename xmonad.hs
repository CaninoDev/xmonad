import		 XMonad.Hooks.ManageDocks

import           KeysMouseBindings
import           Layout
import           LogHook           as LG
import           ManageHook        as M
import           StartupHook       as ST

import           XMonad

main :: IO ()
main = do
    xmonad $ docks myConfig                                 -- Add docks functionality to the given config

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
