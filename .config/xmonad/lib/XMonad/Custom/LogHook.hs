module XMonad.Custom.LogHook where

import           XMonad
------------------------------------------------------------------------
-- Logging

-- | Perform an arbitrary action on each internal state change or X event.
-- Examples include:
--
--      * do nothing
--
--      * log the state to stdout
--
-- See the 'DynamicLog' extension for examples.
--
myLogHook :: X ()
myLogHook = return ()
