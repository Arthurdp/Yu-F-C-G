data Carta = Carta {
    nome :: String,
    ataque :: Int,
    defesa :: Int,
    modoAtaque :: Bool
} deriving (Show)

programacao1 :: Carta
programacao1 = Carta "Programação 1" 600 400 True
