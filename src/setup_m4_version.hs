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

  args <- getArgs
  --nomeficheiro <- return( args !! 0)
  --putStrLn ( "Name is" ++ nomeficheiro)
  --if length args > 0 then putStrLn args else purStrLn Nothing
  mapM_ print args

