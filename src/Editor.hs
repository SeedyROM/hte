{-# LANGUAGE OverloadedStrings #-}

module Editor where

import           Control.Monad
import           Data.Text
import           System.Terminal

handleInput :: IO ()
handleInput =
  withTerminal $
  runTerminalT
    (do ev <- awaitEvent
        putStringLn $ "Event was " ++ show ev
        flush)

term :: IO ()
term = forever $ handleInput
