module ManageHook (
   myManageHook
   , scratchpads
)
where

import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.NamedScratchpad
import XMonad.Util.Scratchpad
import XMonad.Hooks.ManageHelpers
------------------------------------------------------------------------
-- Window rules
-- | Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
--  xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
   where
      h = 0.1
      w = 1
      t = 1 - 1 / 2
      l = 1 - 1 / 2

myManageHook :: ManageHook
myManageHook = composeAll
                [ className =? "vlc"            --> doFloat
                , className =? "mplayer2"       --> doFloat
                , className =? "Settings"       --> doCenterFloat
                , className =? "XMessage"       --> doCenterFloat
                , isDialog                      --> doCenterFloat
                , isFullscreen                  --> (doF W.focusDown <+> doFullFloat)
                , namedScratchpadManageHook scratchpads
                ]
scratchpads =
  [ NS "htop" "st -t process -e htop" (title =? "process") defaultFloating ]
