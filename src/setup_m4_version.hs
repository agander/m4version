{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveDataTypeable #-}

module Main where

import qualified Data.ByteString.Char8 as C8
import System.Environment (getEnv, getProgName, getArgs)
import System.Directory (listDirectory, doesDirectoryExist)
--import Data.List.Split (splitOn)
import System.FilePath (splitFileName, (</>)) -- searchPathSeparator)
import Control.Monad (forM, mapM, forM_, mapM_)
import Data.Text
import qualified Data.Text as T
import Text.Printf
import Data.Text.IO as TIO

--import qualified Lib as L
import Lib
import System.TimeIt
import System.Console.CmdArgs
import Data.Version

import Text.Regex.PCRE.Light

version :: Version
version = makeVersion [0,0,3]

insomma :: Version -> String-> String
insomma version str = str ++ " " ++ showVersion version

newtype Owwica = Args{ search_criteria :: String }
              deriving (Show, Data, Typeable)

data VersionNums = Current 
  | Revision
  | Age
  | Release                 
  deriving (Show, Data, Typeable)

cmd_args = Args{search_criteria = "ch"
  } &= 
  summary (insomma version "Version:") &= 
  program "owwica" &=
  -- verbosityArgs [ignore] [name "silent", explicit] &=
  details ["More details on github.com/agander/setup_m4_version"] &=
  help "setup_m4_version:Usage: stack [-?/--help] [-V/--version] [--numeric-version] [-v|--verbose] "

main :: IO ()
main = do
  prog <- getProgName
  putNPrint "c" "inizio" prog
  args <- cmdArgs cmd_args

  Prelude.putStrLn ">>> COMMENT: args"
  print =<< cmdArgs cmd_args
  --printf "%s: %s\n" "search_criteria" (search_criteria args)

  args <- getArgs
  --print $ parseOptions args

  --nomeficheiro <- return( args !! 0)
  --putStrLn ( "Name is" ++ nomeficheiro)
  --if length args > 0 then putStrLn args else purStrLn Nothing
  -- | Convert args to Text
  let tArgs = Prelude.map T.pack args
  mapM_ print args

  -- | global indicator to check if directory m4/ exists.
  -- Use after to be able to check/create if it doesnt exist.
  haveM4 <- doesDirectoryExist "m4/"
  putNPrint "c" "Do we have m4/?: " haveM4

  -- | Read in the m4/version.m4
  ver_m4 <- TIO.readFile "m4/version.m4"

  -- | Are the args args or values?
  let areArgs = Prelude.filter isArg args
  timeItNamed "args or values" $ mapM_ (putNPrint "c" "isArg: " . isArg) args

  putNPrint  "c" "isSubseqOf \"123\" \"7654321\": " 
    (isSubseqOf "123" "7654321")
-- | Functions
-- | Log message function
--putNPrint :: Show a => Char -> String -> a -> IO ()
putNPrint tipe msg var = do
  case tipe of
      "c" -> Prelude.putStr ">>> COMMENT: "
      "C" -> Prelude.putStr ">>> COMMENT: "
      "w" -> Prelude.putStr "!!! WARNING: "
      "W" -> Prelude.putStr "!!! WARNING: "
      "e" -> Prelude.putStr "*** ERROR:   "
      "E" -> Prelude.putStr "*** ERROR:   "
      "t" -> Prelude.putStr "!!! TEST:    "
      "T" -> Prelude.putStr "!!! TEST:    "
      _   -> Prelude.putStr ">>> INFO:    "
  Prelude.putStr msg
  Prelude.putStr " "
  print var


-- | Setup a m4 version file with:
-- define([VERSION_NUMBER],[0.0.3])dnl
-- where the number is an arg.
--printVersion :: 
--printVersion = 

name_maj_min_regex = compile $ C8.pack "define\\(\\[([A-Z_-]\\w+)\\],\\[(\\d+\\.\\d+)\\.(\\d+)\\]\\)dnl"

