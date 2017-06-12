{-# LANGUAGE UnicodeSyntax #-}

module Main where

import Conduit
import Data.Conduit.List (mapAccum, chunksOf)
import Control.Monad
import GHC.Word (Word8)
import Data.ByteString.Lazy.Internal (defaultChunkSize)

import qualified Data.ByteString as B

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
op flag c = if isSpace c then (True, c) else (False, d)
    where d = if flag then toUpper c else c

-- fd  ∷ Word8 → () → ((), [Word8])
op2 ∷ Word8 → Bool → (Bool, Word8)
op2 c flag = op flag c

-- mapAccum  :: (a -> s -> (s, b)) -> s -> ConduitM a b m s
-- mapAccumL :: (acc -> Word8 -> (acc, Word8)) -> acc -> ByteString -> (acc, ByteString)

data Hole = Hole

chunkify :: (Monad m) => ConduitM Word8 [Word8] m ()
chunkify = chunksOf defaultChunkSize
{-
  some <- takeC defaultChunkSize
  yield some
  chunkify
-}

{-
  /Users/steshaw/Projects/haskell-strings/title-case/src/ConduitByteString.hs:51:6: error:
    • Couldn't match type ‘Bool’ with ‘()’
      Expected type: ConduitM Word8 Word8 (ResourceT IO) ()
        Actual type: ConduitM Word8 Word8 (ResourceT IO) Bool
    • In the first argument of ‘(.|)’, namely ‘mapAccum op2 True’
      In the second argument of ‘(.|)’, namely
        ‘mapAccum op2 True .| chunkify .| mapC B.pack .| stdoutC’
      In the second argument of ‘(.|)’, namely
        ‘concatC
         .| mapAccum op2 True .| chunkify .| mapC B.pack .| stdoutC’
-}

-- capitaliseC :: ConduitM Word8 Word8 (ResourceT IO) Bool
capitaliseC :: ConduitM Word8 Word8 (ResourceT IO) ()
capitaliseC = void $ mapAccum op2 True

main ∷ IO ()
main = runConduitRes $ sourceFile "input.txt"
--  .| decodeUtf8C
--  .| mapAccum op2 True
  .| concatC
  .| capitaliseC
  .| chunkify
  .| mapC B.pack
--  .| encodeUtf8C
  .| stdoutC
