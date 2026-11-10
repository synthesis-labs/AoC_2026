{-# OPTIONS_GHC -Wno-x-partial #-}

module Day04_2019 where

import           Handy
import           Prelude              hiding (some)
import           Text.Megaparsec
import           Text.Megaparsec.Char

input :: IO (Int, Int)
input = parse' ((,) <$> num <* char '-' <*> num <* newline <* eof) <$> puzzle Main 2019 4

adjacent, increasing, groupOfTwo :: Ord a => [a] -> Bool
adjacent a = or $ zipWith (==) a $ tail a
increasing a = and $ zipWith (<=) a $ tail a
groupOfTwo = elem 2 . fmap length . group -- there exists a group of length 2

part1, part2 :: IO Int
part1 = do
    (a,z) <- input
    pure $ length $ filter (adjacent <&&> increasing) $ show <$> [a..z]
part2 = do
    (a,z) <- input
    pure $ length $ filter (adjacent <&&> increasing <&&> groupOfTwo) $ show <$> [a..z]
