module Lib
( someFunc
) where

import qualified Data.Text as T

someFunc :: IO ()
someFunc = putStrLn "someFunc"

argsToTuple :: [T.Text] -> [(T.Text, T.Text)]
argsToTuple  = undefine
--argsToTuple x:xs = [(x : argsToTuple xs)]
--argsToTuple [] = [()]

