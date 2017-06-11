--
-- This one from Chris Doner.
--
-- https://www.reddit.com/r/haskell/comments/120h6i/why_is_this_simple_text_processing_program_so/c6rsebo/
--

module Main where

import GHC.Word (Word8)

import qualified Data.ByteString as B

chr :: Char -> Word8
chr = fromIntegral . fromEnum

toUpper :: Word8 -> Word8
toUpper x = if x >= chr 'a' && x <= chr 'z' then x - chr ' ' else x

fun :: Word8 -> Word8 -> Word8
fun a b | a == chr ' ' || b == chr '\n' = toUpper b
        | otherwise = b

convert :: B.ByteString -> B.ByteString
convert = B.tail . B.scanl fun (chr ' ')

main :: IO ()
main = B.readFile "input.txt" >>= B.putStr . convert
