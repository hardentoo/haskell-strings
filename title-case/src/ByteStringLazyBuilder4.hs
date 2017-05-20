--
-- Duncan Coutts version from reddit:
-- https://www.reddit.com/r/haskell/comments/120h6i/why_is_this_simple_text_processing_program_so/c6rb39p/
--

module Main where

import Data.List (intersperse)
import Data.Monoid
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as C
import qualified Data.ByteString.Lazy.Builder as B
import qualified Data.ByteString.Lazy.Builder.Extras as B

toUpper :: Char -> Char
toUpper 'a' = 'A'
toUpper 'b' = 'B'
toUpper 'c' = 'C'
toUpper 'd' = 'D'
toUpper 'e' = 'E'
toUpper 'f' = 'F'
toUpper 'g' = 'G'
toUpper 'h' = 'H'
toUpper 'i' = 'I'
toUpper 'j' = 'J'
toUpper 'k' = 'K'
toUpper 'l' = 'L'
toUpper 'm' = 'M'
toUpper 'n' = 'N'
toUpper 'o' = 'O'
toUpper 'p' = 'P'
toUpper 'q' = 'Q'
toUpper 'r' = 'R'
toUpper 's' = 'S'
toUpper 't' = 'T'
toUpper 'u' = 'U'
toUpper 'v' = 'V'
toUpper 'w' = 'W'
toUpper 'x' = 'X'
toUpper 'y' = 'Y'
toUpper 'z' = 'Z'
toUpper c = c

convert :: B.ByteString -> B.Builder
convert = unlines' . map convertLine . C.lines

convertLine :: B.ByteString -> B.Builder
convertLine = unwords' . map convertWord . C.words

convertWord :: B.ByteString -> B.Builder
convertWord s = B.char8 (toUpper (C.head s)) <> B.lazyByteStringCopy (C.tail s)

unwords', unlines' :: [B.Builder] -> B.Builder
unwords' = mconcat . intersperse (B.char8 ' ')
unlines' = mconcat . intersperse (B.char8 '\n')

main :: IO ()
main = do
  name <- B.readFile "input.txt"
  B.putStr $ B.toLazyByteString $ convert name
