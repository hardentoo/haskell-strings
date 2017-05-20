module Main where

import Data.Char
import qualified Data.ByteString.Char8 as T

convert :: T.ByteString -> T.ByteString
convert = T.tail . T.scanl (\a b -> if isSpace a then toUpper b else b) ' '

main :: IO ()
main = do
  name <- T.readFile "input.txt"
  T.putStr $ convert name
