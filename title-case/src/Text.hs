module Main (main) where

import Data.Char
import qualified Data.Text as T
import qualified Data.Text.IO as X

convert :: T.Text -> T.Text
convert = T.unlines . (map convertLine) . T.lines

convertLine :: T.Text -> T.Text
convertLine = T.unwords . (map convertWord) . T.words

convertWord :: T.Text -> T.Text
convertWord s = T.cons (toUpper (T.head s)) (T.tail s)

main :: IO ()
main = do
  name <- X.readFile "input.txt"
  X.putStr $ convert name
