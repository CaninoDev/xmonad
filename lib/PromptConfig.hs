module PromptConfig ( myXPConfig, myBrwsrConfig, brwsrPrompt ) where

import           Data.Default        (def)
import           XMonad
import           XMonad.Prompt
import qualified XMonad.Prompt       as XP (XPConfig (..))
import           XMonad.Prompt.Shell
import           XMonad.Util.Run

myXPConfig :: XPConfig
myXPConfig = def { XP.font                = "xft:Roboto Mono:pixelsize=20"
                 , XP.bgColor             = base02
                 , XP.fgColor             = base1
                 , XP.fgHLight            = active
                 , XP.bgHLight            = base02
                 , XP.borderColor         = base01
                 , XP.promptBorderWidth   = 1
                 , XP.position            = CenteredAt 0.25 0.5
                 , XP.height              = 50
                }

myBrwsrConfig :: XPConfig
myBrwsrConfig = def { XP.font              = "xft:RobotoMono Nerd Font:pixelsize=24"
                    , XP.bgColor           = base02
			        , XP.fgColor           = base1
			        , XP.fgHLight          = active
			        , XP.bgHLight          = base02
			        , XP.borderColor       = orange
			        , XP.promptBorderWidth = 1
			        , XP.position          = CenteredAt 0.25 0.5
                    , XP.height            = 50
                    }

data BrwsrPrompt = BrwsrPrompt
type Predicate = String -> String -> Bool

instance XPrompt BrwsrPrompt where
    showXPrompt BrwsrPrompt  = "\59205  https://"
    completionToCommand _ = escape

brwsrPrompt :: FilePath -> XPConfig -> X ()
brwsrPrompt c config = mkXPrompt BrwsrPrompt config (getShellCompl [c] $ searchPredicate config) run
    where run = safeSpawn c . return


escape :: String -> String
escape []       = ""
escape (x:xs)
    | isSpecialChar x = '\\' : x : escape xs
    | otherwise       = x : escape xs

isSpecialChar :: Char -> Bool
isSpecialChar =  flip elem " &\\@\"'#?$*()[]{};"


base03,base02, base01, base00, base0, base1, base2, base3 :: String
yellow,orange,red,magenta,violet,blue,cyan,green :: String
base03  = "#002b36"
base02  = "#073642"
base01  = "#586e75"
base00  = "#657b83"
base0   = "#839496"
base1   = "#93a1a1"
base2   = "#eee8d5"
base3   = "#fdf6e3"
yellow  = "#b58900"
orange  = "#cb4b16"
red     = "#dc322f"
magenta = "#d33682"
violet  = "#6c71c4"
blue    = "#268bd2"
cyan    = "#2aa198"
green   = "#859900"

active  = base2
