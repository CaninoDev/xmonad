{-# OPTIONS -fno-warn-missing-signatures #-}

import XMonad
import XMonad.Hooks.EwmhDesktops (ewmh, ewmhDesktopsEventHook)
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Monitor
import XMonad.Hooks.DynamicLog

import XMonad.Actions.Navigation2D
import XMonad.Actions.UpdatePointer
{- import XMonad.Hooks.UrgencyHook (UrgencyHook, urgencyHook, withUrgencyHook) -}
import KeysMouseBindings
import Layout
import LogHook
import ManageHook
import StartupHook

-- import qualified DBus as D
-- import qualified DBus.Client as D.Client

main :: IO ()
main =
    xmonad =<< statusBar "xmobar" myXmobarPP toggleStrutsKey myConfig  -- Add docks functionality to the given config
  where
    myNavigation2DConfig = def
        { defaultTiledNavigation = hybridNavigation
        }

toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myConfig = def
  { borderWidth               = myBorderWidth
    , workspaces              = myWorkspaces
    , layoutHook              = avoidStruts $ myGaps $ avoidStruts $ layoutHook def          -- Adjust layout automagically to no voer up any dock, status bars, etc...
    , terminal                = myTerminal
    , normalBorderColor       = myNormalBorderColor
    , focusedBorderColor      = myFocusedBorderColor
    , modMask                 = myDefaultModMask
    , keys                    = myKeys
    , logHook                 = dynamicLogWithPP myXmobarPP >>
                              updatePointer (0.5, 0.5) (0, 0)
    , startupHook             = myStartupHook
    , mouseBindings           = myMouseBindings
    , manageHook              = myManageHook
    , focusFollowsMouse       = myFocusFollowsMouse
    , clickJustFocuses        = myClickJustFocuses
    , handleEventHook         = docksEventHook <+> ewmhDesktopsEventHook              -- Whenever a new dock appears, refresh the layout immediately to avoid the new dock
  }
