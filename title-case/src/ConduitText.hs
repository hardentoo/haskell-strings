{-# LANGUAGE UnicodeSyntax #-}

module Main where

import Conduit
import Control.Monad (void)
import Data.Char (toUpper)
import Data.Conduit.List
import qualified Data.Text as T

isSpace :: Char -> Bool
isSpace c = c == ' ' || c == '\n'

capitalise :: Bool -> Char -> (Bool, Char)
capitalise wasSpace c = (isSpaceC, c1)
  where
    isSpaceC = isSpace c
    c1 =
      if wasSpace
        then toUpper c
        else c

capitaliseC :: ConduitM Char Char (ResourceT IO) ()
capitaliseC = void (mapAccum (flip capitalise) True)

main :: IO ()
main =
  runConduitRes $
  sourceFile "input.txt" .| decodeUtf8C .| concatC .| capitaliseC .|
  chunksOf 256 .|
  mapC T.pack .|
  encodeUtf8C .|
  stdoutC
