{-# LANGUAGE OverloadedStrings #-}

module DB ( writeValToDB ) where

import Database.SQLite.Simple
import Data.Time (formatTime, defaultTimeLocale, getZonedTime)

getTime :: IO String
getTime = formatTime defaultTimeLocale "%F %H:%M" <$> getZonedTime

appendTS :: a -> IO (a, String)
appendTS x = ((,) x) <$> getTime

writeRow :: String -> (String, String) -> IO ()
writeRow fn val = do
  conn <- open fn
  execute_ conn "CREATE TABLE IF NOT EXISTS hs(date TEXT, val TEXT)"
  execute conn "INSERT INTO hs (date, val) VALUES (?,?)" val
  close conn

writeValToDB :: String -> String  -> IO ()
writeValToDB fn val = appendTS val >>= writeRow fn
