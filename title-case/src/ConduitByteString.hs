{-# LANGUAGE UnicodeSyntax #-}

module Main where

import Conduit
import Control.Monad
import Criterion.Main
import Data.ByteString.Lazy.Internal (defaultChunkSize)
import Data.Conduit.List (chunksOf, mapAccum)
import GHC.Word (Word8)
import System.Environment

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

capitalise :: Bool -> Word8 -> (Bool, Word8)
capitalise wasSpace c = (isSpace c, c')
  where
    c' =
      if wasSpace
        then toUpper c
        else c

chunkSize :: Int
chunkSize =
  if useSmallChunk
    then 8 * 1024
    else defaultChunkSize
  where
    useSmallChunk = True

-- Old try at implementing "chunkify"
-- chunkify = do
--  some <- takeC defaultChunkSize
--  yield some
--  chunkify
capitaliseC :: ConduitM Word8 Word8 (ResourceT IO) ()
capitaliseC = void $ mapAccum (flip capitalise) True

doMain :: Int -> IO ()
doMain chunkSize =
  runConduitRes $
  sourceFile "input.txt" .| concatC .| capitaliseC .| chunksOf chunkSize .|
  mapC B.pack .|
  stdoutC

benchmark =
  defaultMain
    [ bgroup
        "conduit-byte-string"
        (map (\n -> bench (show n) $ whnfIO (doMain n)) [256, 512])
    ]

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["run", d] -> doMain (read d)
    _ -> benchmark
