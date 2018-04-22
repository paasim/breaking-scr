module Main where

import DB
import Scrape
import System.Environment

main :: IO ()
main = do
  a <- getArgs
  pn <- getProgName
  if length a < 1
    then putStrLn $ "usage: " ++ pn ++ " dbpath"
    else getBn >>= writeValToDB (a !! 0)
