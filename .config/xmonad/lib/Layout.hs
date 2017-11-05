module Layout
  ( myLayout
  , myBorderWidth
  , myWorkspaces
  , myNormalBorderColor
  , myFocusedBorderColor
  , vlcPiP
  ) where

import XMonad
import XMonad (Dimension, Layout, (|||))
import XMonad.Core (WorkspaceId)
import XMonad.Layout
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.OneBig
import XMonad.Layout.Spacing (Spacing, spacing)
import XMonad.Layout.Monitor

vlcPiP = monitor {
    prop = ClassName "vlc"
      , rect = Rectangle 605 318 1196 674
    -- Avoid flickering
    , persistent = True
      , opacity =0.8
    , name = "vlcPiP"
    , visible = True
    }
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
myLayout =
  ModifiedLayout vlcPiP $ spacing 5 $
  (tiled |||
   Mirror tiled ||| oneBig ||| Full ||| noBorders (fullscreenFull Full))
     -- default tiling algorithm partitions the screen into two panes
  where
    tiled = Tall nmaster delta ratio
     -- The default number of windows in the master pane
    nmaster = 1
     -- Default proportion of screen occupied by master pane
    ratio = 1 / 2
     -- Percent of screen to increment by when resizing panes
    delta = 3 / 100
     -- define the one big layout  in terms of portion fo the sreen for the master window to occupy
    oneBig = OneBig (1 / 3) (1 / 3)

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
myWorkspaces = [ "\xf0ac" -- Globus icon
               , "\xf121" -- Code icon
               , "\xf120" -- Terminal icon
               , "4"
               , "5"
               , "6"
               , "7"
               , "8"
               , "\xf26c" -- TV icon
               ]

-- | Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth = 1

-- | Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor :: String
myNormalBorderColor = "#dddddd"

myFocusedBorderColor :: String
myFocusedBorderColor = "#ff0000"

