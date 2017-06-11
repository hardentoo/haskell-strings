{-# LANGUAGE UnicodeSyntax #-}

module Main where

import Conduit
import Data.Char (toUpper)

{-
isSpace ∷ Word8 → Bool
isSpace w = w == _space || w == _nbsp || w <= _cr && w >= _tab

toUpper ∷ Word8 → Word8
toUpper w = if isAsciiLower w then w - _space else w

op ∷ Bool → Word8 → (Bool, Word8)
op flag c = if isSpace c then (True,c) else (False,d)
    where d = if flag then toUpper c else c
-}

main ∷ IO ()
main = runConduitRes $ sourceFile "input.txt"
  .| decodeUtf8C
  .| omapCE toUpper -- mapC (T.map toUpper)
  .| encodeUtf8C
  .| stdoutC
