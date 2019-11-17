{-# LANGUAGE DeriveAnyClass, DeriveGeneric, OverloadedStrings #-}
module Page.GitHub (Repo (..), Language (..), getRepos) where

import Control.Monad.IO.Class
import Data.Aeson
import Data.Aeson.Types
import Data.Maybe
import Data.Text as T
import Debug.Trace
import Distribution.SPDX
import GHC.Generics
import Network.HTTP.Req
import System.Environment

data Language = LangHS
    | LangJS 
    | LangHTML
    | LangPHP
    | LangASM
    | LangGNU
    | LangTS
    | LangCoffee
    | LangShell
    | LangGeneric
    | LangPython
    | LangBlitzBasic
    | LangC
    | LangTcl
    | LangCPP deriving (Eq, Generic, Show)

instance FromJSON Language where
    parseJSON (String a) = return $ case a of
        "JavaScript" -> LangJS
        "HTML" -> LangHTML
        "Python" -> LangPython
        "PHP" -> LangPHP
        "TypeScript" -> LangTS
        "CoffeeScript" -> LangCoffee
        "Shell" -> LangShell
        "Assembly" -> LangASM
        "C" -> LangC
        "Makefile" -> LangShell
        "Visual Basic" -> LangGeneric
        "Dockerfile" -> LangGeneric
        "Tcl" -> LangTcl
        "BlitzBasic" -> LangBlitzBasic
        "Haskell" -> LangHS
        "C++" -> LangCPP
        "Vim script" -> LangShell
        _ -> error $ "Unknown language: " ++ T.unpack a
    parseJSON Null = return LangGeneric

newtype Licence = Licence {
    spdx_id :: String
} deriving (FromJSON, Generic, Show)

data Repo = Repo {
    name :: String,
    description :: Maybe String,
    language :: Language,
    source :: Maybe String,
    website :: Maybe String,
    licence :: Maybe Licence,
    stars :: Int
} deriving (Generic, Show)

instance FromJSON Repo where
    parseJSON (Object a) = do
        homepage <- a .: "homepage"
        -- private <- a .: "private"
        -- fork <- a .: "fork"
        -- fullName <- a .: "full_name"
        url <- a .: "url"
        -- issuesUrl <- a .: "issues_url"
        name <- a .: "name"
        -- forksCount <- a .: "forks_count"
        -- updatedAt <- a .: "updated_at"
        language <- a .: "language"
        -- pushedAt <- a .: "pushed_at"
        -- openIssuesCount <- a .: "open_issues_count"
        -- openIssues <- a .: "open_issues"
        -- watchers <- a .: "watchers"
        stargazers <- a .: "stargazers_count"
        licence <- a .:? "license"
        -- licenceUrl <- licence .: "url"
        -- licenceKey <- licence .: "key"
        -- licenceName <- licence .: "name"
        -- licenceSpdxId <- licence .: "spdx_id"
        -- traceShowM licenceSpdxId
        -- forks <- a .: "forks"
        desc <- a .: "description"
        -- watchersCount <- a .: "watchers_count"

        return $ Repo {
            name = name,
            description = desc,
            language = language,
            source = url,
            website = homepage,
            licence = licence,
            stars = stargazers
        }

getRepos :: Text -> Req [Repo]
getRepos user = do
    githubAccessToken <- liftIO . getEnv $ "GITHUB_ACCESS_TOKEN" -- throws
    res <- req GET (https "api.github.com" /: "users" /: user /: "repos") NoReqBody jsonResponse (
        "per_page" =: ("100" :: Text) <>
        "sort" =: ("pushed" :: Text) <>
        "type" =: ("owner" :: Text) <>
        "direction" =: ("desc" :: Text) <>
        "access_token" =: githubAccessToken <>
        header "User-Agent" "Dan's Haskell Bot v1.0"
        )
    return $ responseBody res