module Cartas where

data Carta = Carta {
    iD :: Int,
    nome :: String,
    ataque :: Int,
    defesa :: Int,
    modoAtaque :: Bool
} deriving (Show)

--Cartas 1 2 periodo

matematicaBasica :: Carta
matematicaBasica = Carta 2  "Matemática básica" 500 700 True 

empolgacao :: Carta
empolgacao = Carta 3  "Empolgação" 900 600 True 

fome :: Carta
fome = Carta 4 "Fome" 800 500 True 

perdeuOnibus :: Carta
perdeuOnibus = Carta 5  "Perdeu ônibus" 600 750 True 

esquecimento :: Carta
esquecimento = Carta 6 "Esquecimento" 800 700 True 

--Cartas 3 4 periodo

bd1 :: Carta
bd1 = Carta 7 "Banco de dados 1" 1100 1300 True 

preguica :: Carta
preguica = Carta 8 "Preguiça" 1500 1200 True 

roubo :: Carta
roubo = Carta 9 "Roubo"  1250 1400 True 

namoro :: Carta
namoro = Carta 10 "Namoro" 1400 1100 True 

sagui :: Carta
sagui = Carta 11 "Sagui" 1100 1500 True 

--Cartas 5 6 periodo

pato :: Carta
pato = Carta 37 "Pato" 1700 1600 True

gato :: Carta
gato = Carta 38 "Gato" 2000 1600 True 

cachorro :: Carta
cachorro =Carta  39 "Cachorro" 1700 2000 True 

metodologiaCientifica :: Carta
metodologiaCientifica = Carta 100 "Metodologia cientifica" 1800 1700 True 

wifi :: Carta
wifi = Carta 101 "Wi-fi" 1600 1900 True 

--Cartas 7 8 periodo

sorte :: Carta
sorte = Carta 102 "Sorte" 2100 2200 True 

amizade :: Carta
amizade = Carta 103 "Amizade" 2400 2200 True 

vicio :: Carta
vicio = Carta 104 "Vício" 2500 2100 True 

iguana :: Carta
iguana = Carta 105 "Iguana" 2200 2500 True 

dorDeCabeca :: Carta
dorDeCabeca = Carta 106 "Dor de cabeça" 2300 2000 True 

--Cartas 9 periodo

laguinho :: Carta
laguinho = Carta 107 "Laguinho" 2500 2700 True

greve :: Carta
greve = Carta 108 "Greve" 2700 2600 True

fimDoMundo :: Carta
fimDoMundo = Carta 109 "Fim do Mundo" 2900 2600 True

insonia :: Carta
insonia = Carta 110 "Insônia" 2700 2500 True 

jacare :: Carta
jacare = Carta 110 "Jacaré" 2800 2700 True 

--Carta vazia

cartaVazia :: Carta
cartaVazia = Carta 00 "carta vazia" 00 00 True

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

repProgramacao1 :: Carta
repProgramacao1 = Carta 12 "Reposição Programação 1" 700 500 True

programacao2 :: Carta
programacao2 = Carta 13 "Programação 2" 800 500 True

repProgramacao2 :: Carta
repProgramacao2 = Carta 14 "Reposição Programação 2" 900 600 True

monitorProgramacao1 :: Carta
monitorProgramacao1 = Carta 15 "Monitor de Programação 1" 800 400 True

monitorProgramacao2 :: Carta
monitorProgramacao2 = Carta 16 "Monitor de Programação 2" 1000 400 True

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

linear :: Carta
linear = Carta 17 "Algebra Linear" 1300 800 True

eda :: Carta
eda = Carta 18 "EDA" 1200 1000 True

repEDA :: Carta
repEDA = Carta 19 "Reposição de EDA (Dalba não perdoará)" 1200 1500 True

leda :: Carta
leda = Carta 20 "LEDA" 1200 1000 True

repLEDA :: Carta
repLEDA = Carta 21 "Reposição de LEDA (Tá ferrado)" 1200 1500 True

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

estatistica :: Carta
estatistica = Carta 22 "Estatística Aplicada" 1600 1000 True

engenhariaSoft :: Carta
engenhariaSoft = Carta 23 "Engenharia de Software" 1700 1300 True

repEstatistica :: Carta
repEstatistica = Carta 24 "Reposição de Estatística Aplicada" 1700 1000 True

repEngenhariaSoft :: Carta
repEngenhariaSoft = Carta 25 "Reposição de Engenharia de Software" 1800 1300 True

iA :: Carta
iA = Carta 26 "Inteligência Artificial" 1800 1700 True

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

compiladores :: Carta
compiladores = Carta 27 "Compiladores" 2000 1500 True

projetoEmComputacao1 :: Carta
projetoEmComputacao1 = Carta 28 "Projeto em computação 1" 2500 2000 True

estagio :: Carta
estagio = Carta 29 "Estágio" 2400 1500 True

repCompiladores :: Carta
repCompiladores = Carta 30 "Reposição de Compiladores" 2200 1500 True

--Cartas 9 periodo

colacao :: Carta
colacao = Carta 60 "colação de grau " 2700 2450 True

formaturaCara :: Carta
formaturaCara = Carta 61 "formatura o zoi da Cara" 2800 2600 True

tcc :: Carta
tcc = Carta 31 "Compiladores" 1000 3000 True 

projetoEmComputacao2 :: Carta
projetoEmComputacao2 = Carta 32 "Projeto em computação 2" 2700 2000 True 

emprego :: Carta
emprego = Carta 33 "Emprego" 2900 2500 True

