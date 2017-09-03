import           KeysMouseBindings
import           Layout
import           LogHook           as LG
import           ManageHook        as M
import           StartupHook       as ST

import           XMonad

main :: IO ()
main = do
    xmonad myConfig

myConfig = def
  { XMonad.borderWidth        = myBorderWidth
  , XMonad.workspaces         = myWorkspaces
  , XMonad.layoutHook         = layout
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
}
