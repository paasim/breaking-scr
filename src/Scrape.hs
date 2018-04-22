module Scrape ( getBn ) where

import qualified Data.ByteString.Lazy.UTF8 as L
import Network.HTTP.Conduit
import Text.HTML.TagSoup

url = "https://www.hs.fi"

getBn :: IO String
getBn = extractContent <$> simpleHttp url

extractContent :: L.ByteString -> String
extractContent = elemToStr
  . takeWhile (~/= "</div>")
  . dropWhile (~/= "<div class=breaking-news>")
  . parseTags

elemToStr :: [Tag L.ByteString] -> String
elemToStr = unwords . words . L.toString . renderTags . filter isTagText
