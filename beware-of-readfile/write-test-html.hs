#!/usr/bin/env stack
{-
  stack script --resolver lts-7.14 
    --package text
    --
    -Wall -fwarn-tabs
-}

main :: IO ()
main = writeFile "test.html"
  "<html><head><meta charset='utf-8'><title>Hello</title></head>\
  \<body><h1>Hello!</h1><h1>שלום!</h1><h1>¡Hola!</h1></body></html>"
