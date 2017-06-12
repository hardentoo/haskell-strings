{-# LANGUAGE UnicodeSyntax #-}

module Main where

import Conduit
import Control.Monad
import Data.ByteString.Lazy.Internal (defaultChunkSize)
import Data.Conduit.List (chunksOf, mapAccum)
import GHC.Word (Word8)

import qualified Data.ByteString as B

chr :: Char -> Word8
chr = fromIntegral . fromEnum

space :: Word8
space = chr ' '

lf :: Word8
lf = chr '\n'

isSpace :: Word8 -> Bool
isSpace w = w == space || w == lf

toUpper :: Word8 -> Word8
toUpper x =
  if x >= chr 'a' && x <= chr 'z'
    then x - space
    else x

op :: Bool -> Word8 -> (Bool, Word8)
op flag c =
  if isSpace c
    then (True, c)
    else (False, d)
  where
    d =
      if flag
        then toUpper c
        else c

chunkify :: (Monad m) => ConduitM Word8 [Word8] m ()
chunkify = chunksOf defaultChunkSize
{-
  some <- takeC defaultChunkSize
  yield some
  chunkify
-}

capitaliseC :: ConduitM Word8 Word8 (ResourceT IO) ()
capitaliseC = void $ mapAccum (flip op) True

main :: IO ()
main =
  runConduitRes $
  sourceFile "input.txt" .| concatC .| capitaliseC .| chunkify .| mapC B.pack .|
  stdoutC
