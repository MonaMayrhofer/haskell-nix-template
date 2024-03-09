module MyLib (someFunc) where

import Text.ANSI
import Data.Text.IO

import System.IO (IO)

someFunc :: IO ()
someFunc = putStrLn (red "someFunc")
