
type Id = Int
type Nome = String
type Ataque = Int
type Defesa = Int
type ModoAtaque = Bool
type Equips = [Carta]

data Carta = Equipamento Id Nome Ataque Defesa | Aluno Id Nome Ataque Defesa ModoAtaque Equips | Monstro Id Nome Ataque Defesa ModoAtaque
 deriving (Show)

--Cartas Tipo Equipamento de Aluno

cafezin :: Carta
cafezin = Equipamento 37 "Cafezin" 600 500 

atestado :: Carta
atestado = Equipamento 38 "atestado médico" 400 1000 

provaEm2 :: Carta
provaEm2 = Equipamento 39 "Prova em dupla" 900 500 

--Cartas Monstro 1 2 periodo

sePerdeu :: Carta
sePerdeu = Monstro 40 "Se perdeu no Campus" 900 700 True

python :: Carta
python = Monstro 41 "Aprender python" 700 600 True

fmcc1 :: Carta
fmcc1 = Monstro 42 "FUND DE MATEMATICA P/ C.DA COMPUTACAO I" 800 800 True

fmcc2 :: Carta
fmcc2 = Monstro 43 "FUND DE MATEMATICA P/ C.DA COMPUTACAO II" 900 900 True

calculo1 :: Carta
calculo1 = Monstro 44 "calculo I" 900 850 True

--Cartas Monstro 3 4 periodo

calculo2 :: Carta
calculo2 = Monstro 45 "calculo II" 1300 1000 True

Haskell :: Carta
Haskell  = Monstro 46 "Aprender Haskell" 1500 1200 True

sono :: Carta
sono  = Monstro 47 "Sono na aula" 1100 1000 True

colaErrada :: Carta
colaErrada = Monstro 48 "cola errada" 1150 1100 True

grafos :: Carta
grafos = Monstro 49 "Video aula de Grafos" 1250 1100 True

--Cartas Monstro 5 6 periodo

crise :: Carta
crise = Monstro 50 "A crise do meio do curso" 1650 1600 True

ead :: Carta
ead = Monstro 51 "o curso agora é EAD" 1900 1800 True

prazo :: Carta
prazo = Monstro 52 "Trabalho com prazo curto" 1800 1700 True

optativasDo6 :: Carta
optativasDo6 = Monstro 53 "Escolher as optativa do 6periodo" 1600 1600 True

perdido :: Carta
perdido = Monstro 54 "Você está perdido no curso" 1900 1850 True

--Cartas Monstro 7 8 periodo

ressaca :: Carta
ressaca = Monstro 55 "Ir para a aula de ressaca" 2100 2200 True

trabalhoGrupo :: Carta
trabalhoGrupo = Monstro 56 "Trabalho em grupo" 2150 2400 True

treta :: Carta
treta = Monstro 57 "Treta no lcc2" 2250 2200 True

pcQuebrado :: Carta
pcQuebrado = Monstro 58 "Seu Pc quebrou, poxa" 2455 2500 True

provas3 :: Carta
provas3  = Monstro 59 "3 provas no mesmo dia" 2500 2450 True

--Cartas Monstro 9 periodo

colacao :: Carta
colacao = Monstro 60 "colação de grau " 2700 2450 True

formaturaCara :: Carta
formaturaCara = Monstro 61 "formatura o zoi da Cara" 2800 2600 True
















