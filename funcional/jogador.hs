module Jogador where
import Cartas

data Jogador = Jogador{
    nomeJogador :: String,
    colecao :: [Carta],
    deck :: [Carta],
    vida :: Int,
    mao :: [Carta],
    cartasCampo :: [Carta],
    derrotados :: [Jogador]
} deriving (Show)

