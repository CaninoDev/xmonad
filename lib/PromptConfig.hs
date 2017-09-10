module PromptConfig ( myXPConfig, myBrwsrConfig, brwsrPrompt, shellPrompt ) where

import           Data.Default        (def)
import           XMonad
import           XMonad.Prompt
import qualified XMonad.Prompt       as XP (XPConfig (..))
import           XMonad.Prompt.Shell hiding (Shell, shellPrompt)
import           XMonad.Util.Run

-- Customize the default Prompt template. The following was extrapolated from the source
data Shell = Shell
instance XPrompt Shell where
    showXPrompt Shell = "\59285 $ "
    completionToCommand _ = escape

shellPrompt :: XPConfig -> X ()
shellPrompt c = do
    cmds <- io getCommands
    mkXPrompt Shell c (getShellCompl cmds $ searchPredicate c) spawn

-- Define the default Prompt template
myXPConfig :: XPConfig
myXPConfig = def { XP.font                = "xft:RobotoMono Nerd Font:pixelsize=24"
                 , XP.bgColor             = base02
                 , XP.fgColor             = base1
                 , XP.fgHLight            = active
                 , XP.bgHLight            = base02
                 , XP.borderColor         = base01
                 , XP.promptBorderWidth   = 1
                 , XP.position            = CenteredAt 0.25 0.5
                 , XP.height              = 50
                 }

-- Create a new prompt for use specifically with browserprompt
data BrwsrPrompt = BrwsrPrompt
type Predicate = String -> String -> Bool

instance XPrompt BrwsrPrompt where
    showXPrompt BrwsrPrompt  = "\59205  "
    completionToCommand _ = escape

brwsrPrompt :: FilePath -> XPConfig -> X ()
brwsrPrompt c config = mkXPrompt BrwsrPrompt config (getShellCompl [c] $ searchPredicate config) run
    where run = safeSpawn c . return

-- Define the BrowserPrompt template
myBrwsrConfig :: XPConfig
myBrwsrConfig =  def { XP.font              = "xft:RobotoMono Nerd Font:pixelsize=24"
                     , XP.bgColor           = base02
                     , XP.fgColor           = base3
                     , XP.fgHLight          = active
                     , XP.bgHLight          = base02
                     , XP.borderColor       = base01
                     , XP.promptBorderWidth = 0
                     , XP.position          = CenteredAt 0.25 0.5
                     , XP.height            = 50
                     }
-- Function to define escape (to get out of the prompt)
escape :: String -> String
escape []       = ""
escape (x:xs)
    | isSpecialChar x = '\\' : x : escape xs
    | otherwise       = x : escape xs

-- Test for special character
isSpecialChar :: Char -> Bool
isSpecialChar =  flip elem " &\\@\"'#?$*()[]{};"

-- Solarized Color Theme
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
