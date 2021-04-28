module Cartas where

data Carta = Carta {
    iD :: Int,
    nome :: String,
    ataque :: Int,
    defesa :: Int,
    modoAtaque :: Bool
} deriving (Show)

cafezin :: Carta
cafezin = Carta 37 "Cafezin" 600 500 True

atestado :: Carta
atestado = Carta 38 "atestado médico" 400 1000 True

provaEm2 :: Carta
provaEm2 = Carta 39 "Prova em dupla" 900 500 True

--Cartas 1 2 periodo

sePerdeu :: Carta
sePerdeu = Carta 40 "Se perdeu no Campus" 900 700 True

python :: Carta
python = Carta 41 "Aprender python" 700 600 True

fmcc1 :: Carta
fmcc1 = Carta 42 "FUND DE MATEMATICA P/ C.DA COMPUTACAO I" 800 800 True

fmcc2 :: Carta
fmcc2 = Carta 43 "FUND DE MATEMATICA P/ C.DA COMPUTACAO II" 900 900 True

calculo1 :: Carta
calculo1 = Carta 44 "calculo I" 900 850 True

--Cartas 3 4 periodo

calculo2 :: Carta
calculo2 = Carta 45 "calculo II" 1300 1000 True

haskell :: Carta
haskell  = Carta 46 "Aprender Haskell" 1500 1200 True

sono :: Carta
sono  = Carta 47 "Sono na aula" 1100 1000 True

colaErrada :: Carta
colaErrada = Carta 48 "cola errada" 1150 1100 True

grafos :: Carta
grafos = Carta 49 "Video aula de Grafos" 1250 1100 True

--Cartas 5 6 periodo

crise :: Carta
crise = Carta 50 "A crise do meio do curso" 1650 1600 True

ead :: Carta
ead = Carta 51 "o curso agora é EAD" 1900 1800 True

prazo :: Carta
prazo = Carta 52 "Trabalho com prazo curto" 1800 1700 True

optativasDo6 :: Carta
optativasDo6 = Carta 53 "Escolher as optativa do 6periodo" 1600 1600 True

perdido :: Carta
perdido = Carta 54 "Você está perdido no curso" 1900 1850 True

--Cartas 7 8 periodo

ressaca :: Carta
ressaca = Carta 55 "Ir para a aula de ressaca" 2100 2200 True

trabalhoGrupo :: Carta
trabalhoGrupo = Carta 56 "Trabalho em grupo" 2150 2400 True

treta :: Carta
treta = Carta 57 "Treta no lcc2" 2250 2200 True

pcQuebrado :: Carta
pcQuebrado = Carta 58 "Seu Pc quebrou, poxa" 2455 2500 True

provas3 :: Carta
provas3  = Carta 59 "3 provas no mesmo dia" 2500 2450 True

--Cartas 9 periodo

colacao :: Carta
colacao = Carta 60 "colação de grau " 2700 2450 True

formaturaCara :: Carta
formaturaCara = Carta 61 "formatura o zoi da Cara" 2800 2600 True
















