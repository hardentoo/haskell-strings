-- From https://www.reddit.com/r/haskell/comments/120h6i/why_is_this_simple_text_processing_program_so/c6rgnq8/
module Main where

import qualified Data.Text.Lazy as T
import qualified Data.Text.Lazy.IO as TIO
import qualified Data.Text.Lazy.Builder as TB
import Data.Monoid ((<>), mconcat)
import Data.Char
import Data.List

convert :: T.Text -> TB.Builder
convert = unlines' . map convertLine . T.lines

convertLine :: T.Text -> TB.Builder
convertLine = unwords' . map convertWord . T.words

convertWord :: T.Text -> TB.Builder
convertWord s = TB.fromString [(toUpper (T.head s))] <> TB.fromLazyText (T.tail s)

unlines' :: [TB.Builder] -> TB.Builder
unlines' = mconcat . intersperse (TB.fromString "\n")

unwords' :: [TB.Builder] -> TB.Builder
unwords' = mconcat . intersperse (TB.fromString " ")

main :: IO ()
main = do
  name <- TIO.readFile "input.txt"
  TIO.putStr $ TB.toLazyText $ convert name
