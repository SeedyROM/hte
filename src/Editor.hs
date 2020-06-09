{-# LANGUAGE OverloadedStrings #-}

module Editor where

import           Data.Text
import           System.Terminal

term :: IO ()
term =
  withTerminal $
  runTerminalT
    (do putTextLn "Hello there, please press a button!"
        flush
        ev <- awaitEvent
        putStringLn $ "Event was " ++ show ev
        flush)
