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

  [args] <- getArgs
  --nomeficheiro <- return( args !! 0)
  --putStrLn ( "Name is" ++ nomeficheiro)
  --if length args > 0 then putStrLn args else purStrLn Nothing
  --mapM print args

  --path <- FilePath "/home/gander/PROJ/haskell/haskellbook"
  entries <- listDirectory "/home/gander/PROJ/haskell/haskellbook"
  --mapM print entries

  str_path <- getEnv "PATH"
  let path = str_to_text str_path
  putStr ">>> COMMENT: PATH: ["
  putStr str_path
  putStrLn "]"

  -- COMPILE_FAIL: 
  --let paths = get_paths path (searchPathSeparator :: String)  -- get a [FilePath]
  let paths = get_paths path ":"  -- get a [FilePath]
  putStrLn ">>> COMMENT: mapM_ print paths"
  mapM_ print paths

  let files = get_files paths
  --let io_files = mapM listDirectory paths
  io_files <- mapM listDirectory paths
  --let files = concat io_files
  putStrLn ">>> COMMENT: mapM_ print (take 5 io_files)"
  mapM_ print (T.take 5 io_files)
  putStrLn ">>> COMMENT: mapM_ print (take 5 files)"
  mapM print (T.take 5 files)

  putStrLn ">>> COMMENT: fin"

-- Define functions for the above work.

str_to_text :: String -> T.Text
  --path <- T.pack $ getEnv "PATH"
str_to_text str = T.pack str

text_to_str :: T.Text -> String
  --path <- T.pack $ getEnv "PATH"
text_to_str str = T.unpack str

-- From a String (${PATH}), return a List-of-Lists split on ':'
--get_paths :: String -> [[Char]]
--get_paths :: String -> [FilePath]
get_paths path delimiter = T.splitOn delimiter path

{-
-- get_files
--get_files :: String -> IO [FilePath]
--get_files :: [FilePath] -> [String]
--get_files :: [String] -> IO [FilePath]
-}
get_files path = do
  contents <- listDirectory path
  rest <- forM contents $ \name -> do
            let newName = path </> name
            isDir <- doesDirectoryExist newName
            if isDir
              then get_files newName
              else return []
  return $ concat rest
{-  let io_files = mapM listDirectory paths
  files <- io_files
  return (concat files)
-}

-- Split each filename and then check if snd() has it.

{-
countEntriesTrad :: FilePath -> IO [(FilePath, Int)]
countEntriesTrad path = do
  contents <- listDirectory path
  rest <- forM contents $ \name -> do
            let newName = path </> name
            isDir <- doesDirectoryExist newName
            if isDir
              then countEntriesTrad newName
              else return []
  return $ (path, length contents) : concat rest

--let str_paths = ["/home/gander/.local/bin" :: FilePath, "/usr/local/bin" :: FilePath ] 
-}

{- -}

