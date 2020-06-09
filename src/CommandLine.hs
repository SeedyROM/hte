{-# LANGUAGE DeriveDataTypeable #-}
{-# LANGUAGE OverloadedStrings  #-}
{-# LANGUAGE TemplateHaskell    #-}

module CommandLine where

import           Data.List
import           Distribution.Package
import           Distribution.PackageDescription.Parsec
import           Distribution.Types.GenericPackageDescription
import           Distribution.Verbosity
import           Distribution.Version
import           System.Console.CmdArgs
import           Text.Printf

import           Editor                                       as Editor

data Arguments =
  Arguments
    { argumentsVerbose :: Bool
    , argumentsFiles   :: [FilePath]
    }
  deriving (Show, Data, Typeable, Eq)

getVersion :: IO String
getVersion = do
  packageDescription <- readGenericPackageDescription silent "hte.cabal" -- Read from the cabal file
  let version =
        intercalate "." $
        map show (versionNumbers $ packageVersion packageDescription)
  return version

arguments :: String -> Mode (CmdArgs Arguments)
arguments version =
  cmdArgsMode $
  Arguments
    { argumentsVerbose = False &= name "v" &= help "Verbose mode"
    , argumentsFiles = def &= args &= typ "FILES"
    } &=
  summary (printf "HTE: The Haskell Text Editor (%s)" version)

run :: IO ()
run = do
  version <- getVersion
  args <- cmdArgsRun (arguments version)
  editor <- Editor.term
  return ()
