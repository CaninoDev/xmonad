module KeysMouseBindings (
myTerminal,
myKeys,
myMouseBindings,
myClickJustFocuses,
myFocusFollowsMouse,
myDefaultModMask
)
where

import qualified Data.Map as M
import XMonad
import qualified XMonad.StackSet as W
import Graphics.X11.ExtraTypes.XF86

import PromptConfig
       (brwsrPrompt, myBrwsrConfig, mySrchConfig, myXPConfig, shellPrompt)
import System.Exit
import qualified XMonad.Actions.Search as S
import qualified XMonad.Actions.Submap as SM
import XMonad.Layout.Monitor
import XMonad.Actions.Minimize
import XMonad.Prompt.Window ( windowPromptGoto )

------------------------------------------------------------------------
-- Key bindings:
-- | The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
myTerminal :: String
myTerminal = "tilix"

-- | The preferred browser, whic is used in a binding below and by certain contrib
-- modules.
myBrowser :: String
myBrowser = "google-chrome"

-- | Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- | Whether a mouse click select the focus or is just passed to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- | modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myDefaultModMask :: KeyMask
myDefaultModMask = mod4Mask -- The command key on Macbook Pro

-- | The xmonad key bindings. Add, modify or remove key bindings here.
--
-- (The comment formatting character is used when generating the manpage)
--
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig {XMonad.modMask = modMask} =
  M.fromList $

    -- launching and killing programs
  [ ((modMask .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- %! Launch terminal
  , ((modMask, xK_p), shellPrompt myXPConfig)
  , ((modMask .|. shiftMask, xK_p), windowPromptGoto myXPConfig)
  , ((modMask, xK_b), brwsrPrompt myBrowser myBrwsrConfig) -- %! Launch web browser
  , ((modMask .|. shiftMask, xK_c), kill) -- %! Close the focused window
  , ((modMask, xK_s), SM.submap $ searchEngineMap $ S.promptSearch mySrchConfig)
  , ((modMask, xK_space), sendMessage NextLayout) -- %! Rotate through the available layout algorithms
  , ((modMask .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf) -- %!  Reset the layouts on the current workspace to default
  , ((modMask, xK_n), refresh) -- %! Resize viewed windows to the correct size

    -- move focus up or down the window stack
  , ((modMask, xK_Tab), windows W.focusDown) -- %! Move focus to the next window
  , ((modMask .|. shiftMask, xK_Tab), windows W.focusUp) -- %! Move focus to the previous window
  , ((modMask, xK_j), windows W.focusDown) -- %! Move focus to the next window
  , ((modMask, xK_k), windows W.focusUp) -- %! Move focus to the previous window
  , ((modMask, xK_m), windows W.focusMaster) -- %! Move focus to the master window

    -- modifying the window order
  , ((modMask, xK_Return), windows W.swapMaster) -- %! Swap the focused window and the master window
  , ((modMask .|. shiftMask, xK_j), windows W.swapDown) -- %! Swap the focused window with the next window
  , ((modMask .|. shiftMask, xK_k), windows W.swapUp) -- %! Swap the focused window with the previous window

    -- resizing the master/slave ratio
  , ((modMask, xK_h), sendMessage Shrink) -- %! Shrink the master area
  , ((modMask, xK_l), sendMessage Expand) -- %! Expand the master area

    -- floating layer support
  , ((modMask, xK_t), withFocused $ windows . W.sink) -- %! Push window back into tiling

    -- increase or decrease number of windows in the master area
  , ((modMask, xK_comma), sendMessage (IncMasterN 1)) -- %! Increment the number of windows in the master area
  , ((modMask, xK_period), sendMessage (IncMasterN (-1))) -- %! Deincrement the number of windows in the master area

    -- minimize/maximize window
  , ((modMask, xK_m), withFocused minimizeWindow)
  , ((modMask .|. shiftMask, xK_m), withLastMinimized maximizeWindowAndFocus)

  -- control monitor
  , ((0, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 10 -steps 1024 -time 80")
  , ((0, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 10 -steps 1024 -time 80")
--  , ((modMask, xK_m), broadcastMessage ToggleMonitor >> refresh)

    -- quit, or restart
  , ((modMask .|. shiftMask, xK_q), io exitSuccess) -- %! Quit xmonad
  , ((modMask .|. shiftMask, xK_r)
    , spawn
        "xmonad --recompile && xmonad --restart && notify-send '\59255 xmonad reloaded successfully'" -- %! Restart xmonad
     )
    -- show keyboard shortcuts (described below)
  , ((modMask .|. shiftMask, xK_slash), helpCommand)
    -- repeat the binding for non-American layout keyboards
  , ((modMask, xK_question), helpCommand)
  ] ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
  [ ((m .|. modMask, k), windows $ f i)
  | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
  , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
  ] ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
  [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
  | (key, sc) <- zip [xK_w, xK_e, xK_r] [0 ..]
  , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
  ]
  where
    helpCommand :: X ()
    helpCommand = spawn ("echo " ++ show help ++ " | xmessage -file -") -- %! Run xmessage with a summary of the default keybindings (useful for beginners)

-- | Mouse bindings: default actions bound to mouse events
myMouseBindings :: XConfig Layout -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings (XConfig {XMonad.modMask = modMask}) =
  M.fromList
    -- mod-button1 %! Set the window to floating mode and move by dragging
    [ ( (modMask, button1)
      , \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster)
    -- mod-button2 %! Raise the window to the top of the stack
    , ((modMask, button2), windows . (W.shiftMaster .) . W.focusWindow)
    -- mod-button3 %! Set the window to floating mode and resize by dragging
    , ( (modMask, button3)
      , \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

-- define the searchlist to use with modMask+s
searchEngineMap method =
  M.fromList $
  [ ((0, xK_s), method S.google)
  , ((0, xK_w), method S.wikipedia)
--  , ((0, xK_e), method S.searchEngine "Etymology" "http://www.etymonline.com/index.php?term=")
 -- , ((0, xK_g), method S.searchEngine "Github" "https://github.com/search?q=")
  ]

-- Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help =
  unlines
    [ "The default modifier key is 'alt'. Default keybindings:"
    , ""
    , "-- launching and killing programs"
    , "mod-Shift-Enter  Launch terminal"
    , "mod-p            Launch prompt"
    , "mod-b            Launch browser"
    , "mod-ctrl-c       Close Focused Window"
    , "mod-s            Launch websearch prompt"
    , "mod-Shift-c      Close/kill the focused window"

    , "mod-n            Resize/refresh viewed windows to the correct size"
    , ""
    , "-- quit, or restart"
    , "mod-Shift-q  Quit xmonad"
    , "mod-q        Restart xmonad"
    , ""
    , "-- Window Management --"
    , ""
    , "mod-Space        Rotate through the available layout algorithms"
    , "mod-Shift-Space  Reset the layouts on the current workSpace to default"
    , "mod-t            Push window back into tiling; unfloat and re-tile it"
    , ""
    , "-- Switching Focus"
    , "mod-Tab          Move focus to the next window"
    , "mod-Shift-Tab    Move focus to the previous window"
    , "mod-j            Move focus to the next window"
    , "mod-k            Move focus to the previous window"
    , "mod-m            Move focus to the master window"
    , ""
    , "-- Modifying the window order"
    , "mod-Return       Swap the focused window and the master window"
    , "mod-Shift-j      Swap the focused window with the next window"
    , "mod-Shift-k      Swap the focused window with the previous window"
    , ""
    , "-- Resizing the master/slave ratio"
    , "mod-h            Shrink the master area"
    , "mod-l            Expand the master area"
    , ""
    , "-- increase or decrease number of windows in the master area"
    , "mod-comma        Increment the number of windows in the master area"
    , "mod-period       Deincrement the number of windows in the master area"
    , ""
    , "-- Workspaces & screens"
    , "mod-[1..9]         Switch to workSpace N"
    , "mod-Shift-[1..9]   Move client to workspace N"
    , "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3"
    , "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3"
    , ""
    , "-- Mouse bindings: default actions bound to mouse events"
    , "mod-button1  Set the window to floating mode and move by dragging"
    , "mod-button2  Raise the window to the top of the stack"
    , "mod-button3  Set the window to floating mode and resize by dragging"
    ]
