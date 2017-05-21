#!/usr/bin/env stack
{-
  stack exec --resolver lts-7.14
    --package criterion
    --
    ghc -O2 -Wall -fwarn-tabs
-}

import           Criterion.Main
import qualified Data.ByteString          as S
import qualified Data.ByteString.Lazy     as L
import qualified Data.Text.Encoding       as T
import           Data.Text.Encoding.Error (lenientDecode)
import qualified Data.Text.IO             as TIO
import qualified Data.Text.Lazy.Encoding  as TL
import qualified Data.Text.Lazy.IO        as TLIO

-- Downloaded from: http://www.gutenberg.org/cache/epub/345/pg345.txt
fp :: FilePath
fp = "pg345.txt"

main :: IO ()
main = defaultMain
    [ bench "String" $ nfIO $ readFile fp
    , bench "Data.Text.IO" $ nfIO $ TIO.readFile fp
    , bench "Data.Text.Lazy.IO" $ nfIO $ TLIO.readFile fp
    , bench "Data.ByteString.readFile" $ nfIO $ S.readFile fp
    , bench "Data.ByteString.Lazy.readFile" $ nfIO $ L.readFile fp
    , bench "strict decodeUtf8" $ nfIO $ fmap T.decodeUtf8 $ S.readFile fp
    , bench "strict decodeUtf8With lenientDecode"
        $ nfIO $ fmap (T.decodeUtf8With lenientDecode) $ S.readFile fp
    , bench "lazy decodeUtf8" $ nfIO $ fmap TL.decodeUtf8 $ L.readFile fp
    , bench "lazy decodeUtf8With lenientDecode"
        $ nfIO $ fmap (TL.decodeUtf8With lenientDecode) $ L.readFile fp
    ]
