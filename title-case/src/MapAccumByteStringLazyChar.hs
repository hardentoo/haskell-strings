--
-- From https://www.reddit.com/r/haskell/comments/120h6i/why_is_this_simple_text_processing_program_so/c6ryf35/
--

{-# LANGUAGE UnicodeSyntax #-}

module Main where

import Data.Char
import qualified Data.ByteString.Lazy.Char8 as C

cc :: Bool → Char → (Bool, Char)
cc inWord c
  | isAsciiLower c =
      (True, if inWord then c else chr (ord c - 32))
  | isAsciiUpper c =
      (True, c)
  | otherwise =
      (False, c)

convert :: C.ByteString → C.ByteString
convert = snd . C.mapAccumL cc False 

main :: IO ()
main = do
  name ← C.readFile "input.txt"
  C.putStr $ convert name
