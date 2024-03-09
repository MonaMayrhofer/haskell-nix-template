module Main where

import qualified MyLib (someFunc)

import Prelude

main :: IO ()
main = do
  putStrLn "Hello, Haskell! 🎉"
  MyLib.someFunc
