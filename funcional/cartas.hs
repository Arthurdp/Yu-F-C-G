data Carta = Carta {
    id :: int,
    nome :: String,
    ataque :: Int,
    defesa :: Int,
    modoAtaque :: Bool
} deriving (Show)

programacao1 :: Carta
programacao1 = Carta "Programação 1" 600 400 True

--Cartas 1 2 periodo

matematicaBasica :: Carta
matematicaBasica = Carta "Matemática básica" 500 700 True 

empolgacao :: Carta
empolgacao = Carta "Empolgação" 900 600 True 

fome :: Carta
fome = Carta "Fome" 800 500 True 

perdeuOnibus :: Carta
perdeuOnibus = Carta "Perdeu ônibus" 600 750 True 

esquecimento :: Carta
esquecimento = Carta "Esquecimento" 800 700 True 

--Cartas 3 4 periodo

bd1 :: Carta
bd1 = Carta "Banco de dados 1" 1100 1300 True 

preguica :: Carta
preguica = Carta "Preguiça" 1500 1200 True 

roubo :: Carta
roubo = Carta "Roubo"  1250 1400 True 

namoro :: Carta
namoro = Carta "Namoro" 1400 1100 True 

sagui :: Carta
sagui = Carta "Sagui" 1100 1500 True 

--Cartas 5 6 periodo

pato :: Carta
pato = Carta "Pato" 1700 1600 True

gato :: Carta
gato = Carta "Gato" 2000 1600 True 

cachorro :: Carta
cachorro = Carta "Cachorro" 1700 2000 True 

metodologiaCientifica :: Carta
metodologiaCientifica = Carta "Metodologia cientifica" 1800 1700 True 

wifi :: Carta
wifi = Carta "Wi-fi" 1600 1900 True 

--Cartas 7 8 periodo

sorte :: Carta
sorte = Carta "Sorte" 2100 2200 True 

amizade :: Carta
amizade = Carta "Amizade" 2400 2200 True 

vicio :: Carta
vicio = Carta "Vício" 2500 2100 True 

iguana :: Carta
iguana = Carta "Iguana" 2200 2500 True 

dorDeCabeca :: Carta
dorDeCabeca = Carta "Dor de cabeça" 2300 2000 True 

--Cartas 9 periodo

laguinho :: Carta
laguinho = Carta "Laguinho" 2500 2700 True

greve :: Carta
greve = Carta "Greve" 2700 2600 True

fimDoMundo :: Carta
fimDoMundo = Carta "Fim do Mundo" 2900 2600 True

insonia :: Carta
insonia = Carta "Insônia" 2700 2500 True 

jacare :: Carta
jacare = Carta "Jacaré" 2800 2700 True 
