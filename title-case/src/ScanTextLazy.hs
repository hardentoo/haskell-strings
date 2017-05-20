module Main where

import Data.Char

import qualified Data.Text.Lazy as TL
import qualified Data.Text.Lazy.IO as TLIO

convert :: TL.Text -> TL.Text
convert = TL.tail . TL.scanl (\a b -> if isSpace a then toUpper b else b) ' '

main :: IO ()
main = do
  name <- TLIO.readFile "input.txt"
  TLIO.putStr $ convert name
