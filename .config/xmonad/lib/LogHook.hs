module LogHook where

import XMonad
import XMonad.Hooks.DynamicLog

import XMonad.Util.Run
import XMonad.Util.NamedScratchpad


import GHC.IO.Handle.Types


import Colors

-- Xmobar
myXmobarPP :: PP
myXmobarPP = xmobarPP
    { ppCurrent         = xmobarColor myBlue myBlack
    , ppHiddenNoWindows = xmobarColor myGray myBlack
    , ppUrgent          = xmobarColor myDarkGray myDarkRed
    , ppVisible         = xmobarColor myGreen myBlack
    , ppSep             = " : "
    , ppLayout          = xmobarColor myLighterGray ""
    , ppOrder           = \(ws:l:t:_) -> [" " ++ l,ws,t]
    , ppTitle           = xmobarColor myLighterGray "" . shorten 70 
    , ppSort            = (. namedScratchpadFilterOutWorkspace) <$> ppSort def
    }

myXmobar :: String
myXmobar = "LC_ALL=ru_RU.UTF-8 xmobar"
