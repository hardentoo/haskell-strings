#!/usr/bin/env stack
{-
  stack script --resolver lts-8.14
    --package base
    --
    -Wall -fwarn-tabs
-}

module Main where

import Control.Monad (replicateM_)
import System.IO

main :: IO ()
main = do
  lorem <- readFile "lorem.txt"
  withFile "input.txt" WriteMode $ \handle -> do
    replicateM_ (60 * 1000) $ hPutStr handle lorem
