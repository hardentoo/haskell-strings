#!/usr/bin/env stack
{-
  stack script --resolver lts-8.14
    --package base
-}

-- Adapted from http://stackoverflow.com/a/2937333/482382


-- Note: This source file is encoded as UTF-8.
--
-- >>> $ file eg.hs
-- >>> eg.hs: a /usr/bin/env stack script text executable, UTF-8 Unicode text
--

import System.IO

alpha1 = [toEnum 0x03B1] {- α -}

alpha2 = "α"

out s handle = do
  hSetEncoding handle utf8
  hPutStrLn handle s

main = do
  out alpha1 stdout
  out alpha2 stdout
  putStrLn alpha1
  putStrLn alpha2
