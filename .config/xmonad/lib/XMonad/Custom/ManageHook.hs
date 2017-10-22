module XMonad.Custom.ManageHook where

import           XMonad

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
manageHook :: ManageHook
manageHook = composeAll
                [ className =? "MPlayer"        --> doFloat
                , className =? "mplayer2"       --> doFloat ]
