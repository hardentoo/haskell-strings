module Main where

import Data.Char
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as C

convert :: B.ByteString -> B.ByteString
convert = C.unlines . (map convertLine) . C.lines

convertLine :: B.ByteString -> B.ByteString
convertLine = C.unwords . (map convertWord) . C.words

convertWord :: B.ByteString -> B.ByteString
convertWord s = C.cons (toUpper (C.head s)) (C.tail s)

main :: IO ()
main = do
  name <- B.readFile "input.txt"
  B.putStr $ convert name
