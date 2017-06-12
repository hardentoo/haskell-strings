{-# LANGUAGE UnicodeSyntax #-}

module Main where

import GHC.Word (Word8)
import qualified Data.ByteString.Lazy as B

chr :: Char -> Word8
chr = fromIntegral . fromEnum

space :: Word8
space = chr ' '

lf :: Word8
lf = chr '\n'

isSpace ∷ Word8 → Bool
isSpace w = w == space || w == lf

toUpper :: Word8 -> Word8
toUpper x = if x >= chr 'a' && x <= chr 'z' then x - space else x

op ∷ Bool → Word8 → (Bool, Word8)
op flag c = if isSpace c then (True,c) else (False,d)
    where d = if flag then toUpper c else c

main ∷ IO ()
main = B.readFile "input.txt" >>= B.putStr . snd . B.mapAccumL op True
