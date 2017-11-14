{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.ByteString as B
import System.Environment (getEnv, getProgName, getArgs)
import System.Directory (listDirectory, doesDirectoryExist)
--import Data.List.Split (splitOn)
import System.FilePath (splitFileName, (</>)) -- searchPathSeparator)
import Control.Monad (forM, mapM, forM_, mapM_)
import qualified Data.Text as T

import Lib

--tokenise x y = h : if null t then [] else tokenise x (drop (length x) t)
--    where (h,t) = B.breakSubstring x y

main :: IO ()
main = do
  putStrLn ">>> COMMENT: inizio"
  prog <- getProgName
  putStr ">>> COMMENT: arg[0]: ["
  putStr prog
  putStrLn "]"
  putNPrint "c" "inizio" prog

  args <- getArgs
  --nomeficheiro <- return( args !! 0)
  --putStrLn ( "Name is" ++ nomeficheiro)
  --if length args > 0 then putStrLn args else purStrLn Nothing
  mapM_ print args

  -- | global indicator to be able to test/set if m4/exists.
  haveM4 <- doesDirectoryExist "m4/"
  putNPrint "c" "Do we have m4/?: " haveM4

-- | Functions
-- | Log message function
--putNPrint :: Show a => Char -> String -> a -> IO ()
putNPrint tipe msg var = do
  case tipe of
      "c" -> putStr ">>> COMMENT: "
      "C" -> putStr ">>> COMMENT: "
      "w" -> putStr "!!! WARNING: "
      "W" -> putStr "!!! WARNING: "
      "e" -> putStr "*** ERROR:   "
      "E" -> putStr "*** ERROR:   "
      _   -> putStr ">>> INFO:    "
  putStr msg
  putStr " "
  print var


