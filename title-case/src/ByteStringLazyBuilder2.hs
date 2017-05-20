--
-- Duncan Coutts version from reddit:
-- https://www.reddit.com/r/haskell/comments/120h6i/why_is_this_simple_text_processing_program_so/c6rb39p/
--

module Main where

import Data.Char
import Data.List (intersperse)
import Data.Monoid
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as C
import qualified Data.ByteString.Lazy.Builder as B
import qualified Data.ByteString.Lazy.Builder.Extras as B

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
