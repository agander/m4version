module Lib
--( someFunc , isArg)
where

import qualified Data.Text as T
import System.IO

someFunc :: IO ()
someFunc = putStrLn "someFunc"

argsToTuple :: [T.Text] -> [(T.Text, T.Text)]
argsToTuple  = undefined
--argsToTuple [] = []
--argsToTuple (xs@x:y:ys) =
--  case isArg (x:y) of
--    True -> 

isArg (x:y:_) = if x == '-' && y == '-' then True else False

--argsToTuple xs@x:y:ys = [(x : argsToTuple xs)]

data ParseResult = Help | PrintVersion | Run Options | ParseError
  deriving (Eq, Show)

data Verbose = Verbose | NoVerbose
  deriving (Eq, Show)

data Force = Force | NoForce
  deriving (Eq, Show)

data Options = Options {
  optionsVerbose :: Verbose
, optionsForce :: Force
, optionsToStdout :: Bool
, optionsTarget :: Maybe FilePath
} deriving (Eq, Show)

printHelp :: IO ()
printHelp = do
  hPutStrLn stderr $ unlines
    [
        "Usage: setup_m4_version [ --silent ] [ --force | -f ] [ PATH ] [ - ]"
      , "       setup_m4_version --version"
      , "       setup_m4_version --help"
    ]


{-
parseOptions :: [String] -> ParseResult
parseOptions xs = case xs of
  ["--version"] -> PrintVersion
  ["--help"] -> Help
  _ -> case targets of
    Just (target, toStdout) -> Run (Options verbose force toStdout target)
    Nothing -> ParseError
    where
      silentFlag = "--silent"
      forceFlags = ["--force", "-f"]

      flags = [silentFlag] ++ forceFlags
      verbose = if silentFlag `elem` xs then NoVerbose else Verbose
      force = if any (`elem` xs) forceFlags then Force else NoForce
      ys = filter (`notElem` flags) xs

      targets = case ys of
        ["-"] -> Just (Nothing, True)
        ["-", "-"] -> Nothing
        [dir] -> Just (Just dir, False)
        [dir, "-"] -> Just (Just dir, True)
        [] -> Just (Nothing, False)
_ -> Nothing
-}

-- | This should return True if (and only if) all the values in
-- the first list appear in the second list, though they need
-- not be contiguous.
{-
Prelude> isSubseqOf "blah" "blahwoot"
True
Prelude> isSubseqOf "blah" "wootblah"
True
Prelude> isSubseqOf "blah" "wboloath"
True
Prelude> isSubseqOf "blah" "wootbla"
False
Prelude> isSubseqOf "blah" "halbwoot"
False
Prelude> isSubseqOf "blah" "blawhoot"
True

-} 
isSubseqOf :: (Eq a)
           => [a]
           -> [a]
           -> Bool
--isSubseqOf = undefined
isSubseqOf [] [] = False
isSubseqOf _ []  = False
isSubseqOf [] _  = False
isSubseqOf (x:xs) (y:ys) = False

