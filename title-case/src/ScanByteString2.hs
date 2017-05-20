--
-- From https://www.reddit.com/r/haskell/comments/120h6i/why_is_this_simple_text_processing_program_so/c6rns0b/
--

module Main (main) where

import Data.Char (chr, ord)

import qualified Data.ByteString.Char8 as B

isSpace :: Char -> Bool
isSpace ' '  = True
isSpace '\t' = True
isSpace '\n' = True
isSpace '\r' = True
isSpace _    = False

toUpper :: Char -> Char
toUpper x
  | x >= 'a' && x <= 'z' = chr $ ord x - 32
  | otherwise = x

fun :: Char -> Char -> Char
fun a b | isSpace a = toUpper b
        | otherwise = b

convert :: B.ByteString -> B.ByteString
convert = B.tail . B.scanl fun ' '

main :: IO ()
main = B.readFile "input.txt" >>= B.putStr . convert
