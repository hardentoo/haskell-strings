-- From https://honza.ca/2012/10/haskell-strings

module Main where

import Data.Char

convert :: String -> String
convert = unlines . (map convertLine) . lines

convertLine :: String -> String
convertLine = unwords . (map convertWord) . words

convertWord :: String -> String
convertWord s = (toUpper (head s)):(tail s)

main :: IO ()
main = do
  name <- readFile "input.txt"
  putStr $ convert name
