module LogHook
  ( myLogHook
  ) where

import XMonad
import XMonad.Hooks.DynamicLog

myLogHook :: X ()
myLogHook = dyanmicLogWithPP xmobarPP
  { ppOutput = hPutStrLn xmproc
           , ppTitle = xmobarColor "#657b83" "" . shorten 100
           , ppCurrent = xmobarColor "#c0c0c0" "" . wrap "" ""
           , ppSep     = xmobarColor "#c0c0c0" "" " | "
           , ppUrgent  = xmobarColor "#ff69b4" ""
           , ppLayout = const "" -- to disable the layout info on xmobar
}
