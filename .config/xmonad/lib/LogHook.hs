module LogHook
  ( myLogHook
  , dBusInterface
  , dBusPath
  , dBusMember
  {- , connectDBusClient -}
  ) where

import qualified DBus as D
import qualified DBus.Client as D

import XMonad
import XMonad.Hooks.EwmhDesktops (ewmhDesktopsLogHook)

import XMonad.Hooks.DynamicLog

import qualified Codec.Binary.UTF8.String as UTF8

-- Define the specific parameters for this dbus Connection
dBusInterface = "org.xmonad.Log"

dBusPath = "/org/xmonad/log"

dBusMember = "Update"

myLogHook :: D.Client -> X ()
myLogHook dbusLine = do
  dynamicLogWithPP $ def {ppOutput = signalDBus dbusLine}
  {- ewmhDesktopsLogHook -}

-- Called in xmonad.hs, placed here for legibility
{- connectDBusClient :: IO D.Client -}
{- connectDBusClient = do -}
{-   client <- D.connectSession -}
{-   D.requestName client (D.busName_ dBusInterface) dBusParams -}
{-   return client -}
{-   where -}
{-     dBusParams = -}
{-       [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue] -}
-- This is the meat of the interface between dbus and xmonad via dynamicLogWithPP
{- processDBusLog :: D.Client -> X () -}
{- processDBusLog dbusLine -}
-- Emit a DBus signal on log updates
signalDBus :: D.Client -> String -> IO ()
signalDBus client message = do
  let signal =
        (D.signal objectPath interfaceName memberName)
        {D.signalBody = [D.toVariant $ UTF8.decodeString message]}
  D.emit client signal
  where
    objectPath = D.objectPath_ dBusPath
    interfaceName = D.interfaceName_ dBusInterface
    memberName = D.memberName_ dBusMember
