module Layout (layout,myBorderWidth, myWorkspaces, myNormalBorderColor, myFocusedBorderColor) where

import           XMonad                (Dimension, Layout, (|||))
import           XMonad.Core           (WorkspaceId)
import           XMonad.Layout
import           XMonad.Layout.Spacing (Spacing, spacing)
------------------------------------------------------------------------
-- Extensible layouts
--
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--

-- | The available layouts.  Note that each layout is separated by |||, which
-- denotes layout choice.
layout = spacing 10 $ (tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

-- | The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces :: [WorkspaceId]
myWorkspaces = map show [1 .. 9 :: Int]

-- | Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth = 1

-- | Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor :: String
myNormalBorderColor  = "#dddddd"

myFocusedBorderColor :: String
myFocusedBorderColor = "#ff0000"
