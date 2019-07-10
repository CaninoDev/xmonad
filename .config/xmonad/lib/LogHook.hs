module LogHook where

import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Actions.CycleWS
import XMonad.Layout.ShowWName
import XMonad.Util.Run

import GHC.IO.Handle.Types

import Colors

-- xmobar log hook configuration

-- xmobarEscape :: String -> String
-- xmobarEscape = concatMap doubleLts
--   where doubleLts '<' = "<<"
--         doubleLts x   = [x]

-- -- | make a workspace name clickable for xmobar.
-- --   Works as long as the first character of the name is the corresponding key.  If you
-- --   want meaningful names, use things like 1-fooxmobarClickWrap :: String -> String
-- xmobarClickWrap ws = wrap start end (xmobarEscape ws)
--   where start = "<action=xdotool key super+" ++ wsKeyName ws ++ ">"
--         end   = "</action>"

-- wsKeyName::String -> String
-- wsKeyName ws = case head ws of { '=' -> "equal"; '-' -> "minus"; x -> [x]; }

--xmobarLogHook pipe = dynamicLogWithPP xmobarPP
myXmobarPP = xmobarPP
    {
    --ppOutput = hPutStrLn
    ppCurrent = xmobarColor myYellow "" . wrap "[" "]"          . xmobarClickWrap
    , ppHidden  = xmobarColor myDarkestGray ""                  . xmobarClickWrap
    , ppHiddenNoWindows = xmobarColor  myWhite ""               . xmobarClickWrap
    , ppVisible = xmobarColor myLighterstGray "" . wrap "(" ")" . xmobarClickWrap
    , ppUrgent  = xmobarColor myRed myYellow                    . xmobarClickWrap
    , ppTitle   = xmobarColor myGreen  ""
    }

myXmobar :: String
myXmobar = "xmobar"
