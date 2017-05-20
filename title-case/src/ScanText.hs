module Main where

import Data.Char

import qualified Data.Text as T
import qualified Data.Text.IO as TIO

convert :: T.Text -> T.Text
convert = T.tail . T.scanl (\a b -> if isSpace a then toUpper b else b) ' '

main = do
  name <- TIO.readFile "input.txt"
  TIO.putStr $ convert name
