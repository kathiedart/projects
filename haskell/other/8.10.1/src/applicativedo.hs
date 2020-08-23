{-# LANGUAGE ApplicativeDo #-}

import           Data.Functor.Compose

main :: IO ()
main = do
    print . getCompose $ c
    print d

c :: Compose [] [] (Char, Char)
c = do
    a <- Compose ["aa"]
    b <- Compose ["bb"]
    return (a, b)

-- tbh this could work with monads too
d :: [Int]
d = do
    a <- [1..5]
    b <- [1..9]
    return $ a + b -- (+) <$> a <*> b

