{-# LANGUAGE DeriveFunctor              #-}
{-# LANGUAGE ExistentialQuantification  #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE RankNTypes                 #-}
{-# LANGUAGE Strict                     #-}
{-# LANGUAGE UnicodeSyntax              #-}

import           Control.Applicative
import           Data.Functor.Compose
import           Data.Functor.Contravariant

dat2 ∷ Maybe [Int]
dat2 = Just [1,2,3]

dat3 ∷ Maybe [(Int, Int)]
dat3 = Just [(0, 1),(1, 2),(2, 3)]

-- TODO generalise

type DoubleCompose f g h x = Compose (Compose f g) h x

compose2 ∷ f (g (h x)) → DoubleCompose f g h x
compose2 = Compose . Compose

getCompose2 ∷ DoubleCompose f g h x → f (g (h x))
getCompose2 = getCompose . getCompose

newtype ComposeTwo f g h x = ComposeTwo {
    getComposeTwo :: f (g (h x))
} deriving (Functor)

-- uhh... maybe?

-- instance (Applicative f, Applicative g, Applicative h) => Applicative (ComposeTwo f g h) where
--     pure = ComposeTwo . pure

i ∷ Int
i = 1


main ∷ IO ()
main = do
    putStrLn "Double functor"
    print $ fmap (+1) <$> dat2
    print . getCompose $ ((+1) <$> Compose dat2)
    putStrLn "Triple functor"
    print $ fmap (fmap (+1)) <$> dat3
    print . getCompose $ (fmap (+1) <$> Compose dat3)
    putStrLn "Triple functor without an extra fmap"
    print . getCompose $ getCompose ((+1) <$> Compose (Compose dat3))
    print . getCompose $ getCompose (fmap (+1) . Compose $ Compose dat3)
    putStrLn "Double compose functions"
    print . getCompose2 $ ((+1) <$> compose2 dat3)
    putStrLn "Double compose newtype"
    print . getComposeTwo $ ((+1) <$> ComposeTwo dat3)
    putStrLn "Const"
    print . getConst $ ((+i) <$> Const i)
    putStrLn "Contra"
    -- map?
    print $ (getComparison $ Comparison compare) i i
    -- Equivalence
    print $ (getEquivalence $ Equivalence (==)) i i
    -- Op
    print $ getOp (Op show) i
    print $ (getPredicate . contramap (+i) $ Predicate (==2)) i
