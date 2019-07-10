module Layout
  ( myBorderWidth
  , myWorkspaces
  , myNormalBorderColor
  , myFocusedBorderColor
  , myGaps
  ) where

import XMonad
import XMonad (Dimension, (|||))
import XMonad.Core (WorkspaceId)
import XMonad.Layout
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.OneBig
import XMonad.Layout.Spacing
import XMonad.Layout.Monitor
import XMonad.Layout.Minimize
import XMonad.Layout.Named
import XMonad.Layout.ShowWName
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

-- Extensible layouts
--
-- You can specify and transform your layouts by modifying these value.
-- If you change layout binding to use the the 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to teh new
-- defaults, as xmonad preserves your old layout settings by default
--
-- The available layouts. Note that each layout is separated by |||, which
-- denotes layout choice.
-- myLayouts =
--   smartBorder $ avoidStruts $ showWName $
--   (tiled ||| Mirror tiled ||| oneBig ||| wide)
--   where
--     tiled = named "tiled" $ Tall nmaster delta ratio
--     -- The default number of windows in the master pane
--     nmaster = 1
--     --
--     -- Default proportion of screen occupied by master pane
--     ratio = 1 / 2
--     -- Percent of screen to increment by when resizing pane
--     delta = 3 / 100
--     -- Define the oneBig layout in terms of portions of the screen for the
--     -- master window to occupy
--     oneBig = named "oneBig" $ OneBig (1 / 3) (1 / 3)
--     -- The golden ratio to use for the wide layout
--     phi = (2 / (1 + (toRational(sqrt(5)::Double))))
--     -- Define the layout using the above golden ratio
--     wide = named "wide" $ Mirror $ Tall $ 1 (2 / 100) phi
--
-- -- Workspaces
-- -- By default, we use numeric strings, but any string may be used as a
-- -- workspace name. The number of workspaces is determined by the length
-- -- of this list.
-- --
-- -- A tagging example:
-- -- > worspaces = ["web", "irc", "code"] ++ map show [4..9]
-- --
named_ws = [ "<fn=2>\xf120<\fn>" -- term
           , "<fn=2>\xf121<\fn>" -- code
           , "<fn=2>\xf0ac<\fn>" -- web
           , "<fn=2>\xf0ad<\fn>" -- sys
           , "<fn=2>\xf0eb<\fn>" -- chat
           , "<fn=2>\xf085<\fn>" -- media
           , "<fn=2>\xf1fc<\fn>" -- art
           ]
-- myWorkspaces = clickable workspaces
--   where
--     workspaces = named_ws ++ unnamed_ws
--     unnamed_ws = let l = length named_ws
--                      s = max 0 $ 12 - l
--                  in take s [[c] | c <- ['A'..]]
--     clickable ws = [ "<action=wmctrl -s " ++ w ++ ">" ++ wrap "." "." name ++ "<\action>" | (n, name) <- zip [1..length named_ws] ws , let w = show $ n - 1 ]
xmobarEscape = concatMap doubleLts
  where doubleLts '<' = "<<"
        doubleLts x   = [x]

myWorkspaces :: [String]
myWorkspaces = clickable . (map xmobarEscape) $ ["1","2","3","4","5"]

  where
         clickable l = [ "<action=xdotool key alt+" ++ show (n) ++ ">" ++ ws ++ "</action>" |
                             (i,ws) <- zip [1..5] l,
                            let n = i ]
myBorderWidth :: Dimension
myBorderWidth = 2

myNormalBorderColor :: String
myNormalBorderColor = "#ddddd"

myFocusedBorderColor :: String
myFocusedBorderColor = "#ff000"

myGaps = spacingRaw True (Border 0 0 0 0) False (Border 8 8 8 8) True -- gaps (border / window spacing)
