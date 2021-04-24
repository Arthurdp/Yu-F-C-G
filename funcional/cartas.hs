data Carta = Carta {
    id :: Int,
    nome :: String,
    ataque :: Int,
    defesa :: Int,
    modoAtaque :: Bool,
    tipo :: String
} deriving (Show)

--Cartas Tipo Equipamento de Aluno

cafezin :: Carta
cafezin = Carta 37 "Cafezin" 600 500 True "Equip"

atestado :: Carta
atestado = Carta 38 "atestado médico" 400 1000 True "Equip"

provaEm2 :: Carta
provaEm2 = Carta 39 "Prova em dupla" 900 500 True "Equip"
