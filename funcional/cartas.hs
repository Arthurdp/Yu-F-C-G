module Cartas where

data Carta = Carta {
    iD :: Int,
    nomeCarta :: String,
    ataque :: Int,
    defesa :: Int,
    modoAtaque :: Bool,
    atacou :: Bool
} deriving (Show)


--Carta vazia

cartaVazia :: Carta
cartaVazia = Carta 0 "carta vazia" 00 00 True  False

--Cartas 1 2 periodo

sePerdeu :: Carta
sePerdeu = Carta 1 "Se perdeu no Campus" 900 700 True  False

matematicaBasica :: Carta
matematicaBasica = Carta 2  "Matematica basica" 500 700 True  False 

empolgacao :: Carta
empolgacao = Carta 3  "Empolgacao" 900 600 True  False 

fome :: Carta
fome = Carta 4 "Fome" 800 500 True  False 

perdeuOnibus :: Carta
perdeuOnibus = Carta 5  "Perdeu onibus" 600 750 True  False 

esquecimento :: Carta
esquecimento = Carta 6 "Esquecimento" 800 700 True  False

python :: Carta
python = Carta 7 "Aprender python" 700 600 True  False

fmcc1 :: Carta
fmcc1 = Carta 8 "FUND DE MATEMATICA P/ C.DA COMPUTACAO I" 800 800 True  False

fmcc2 :: Carta
fmcc2 = Carta 9 "FUND DE MATEMATICA P/ C.DA COMPUTACAO II" 900 900 True  False

calculo1 :: Carta
calculo1 = Carta 10 "calculo I" 900 850 True  False

fe :: Carta
fe = Carta 11 "fe" 700 800 True  False

repProgramacao1 :: Carta
repProgramacao1 = Carta 12 "Reposicao Programacao 1" 700 500 True  False

programacao2 :: Carta
programacao2 = Carta 13 "Programacao 2" 800 500 True  False

repProgramacao2 :: Carta
repProgramacao2 = Carta 14 "Reposicao Programacao 2" 900 600 True  False

monitorProgramacao1 :: Carta
monitorProgramacao1 = Carta 15 "Monitor de Programacao 1" 800 400 True  False

monitorProgramacao2 :: Carta
monitorProgramacao2 = Carta 16 "Monitor de Programacao 2" 1000 400 True  False

uniao :: Carta
uniao = Carta 17 "uniao" 800 1000 True  False

conselhoEstudantil :: Carta
conselhoEstudantil = Carta 18 "conselho estudandil" 1000 1000 True  False

livia :: Carta
livia = Carta 19 "professora livia" 750 1000 True  False

galdencioAmansado :: Carta
galdencioAmansado = Carta 20 "professor galdencio manso" 900 800 True  False

joseFernando :: Carta
joseFernando = Carta 21 "professor jose fernando" 950 500 True  False

eanesBenevolente :: Carta
eanesBenevolente = Carta 22 "eanes em estado de benevolencia" 500 900 True  False

robertKalley :: Carta
robertKalley = Carta 23 "Professor robertKalley" 500 1000 True  False

zeFuinha :: Carta
zeFuinha = Carta 24 "aluno ze fuinha" 1050 800 True  False


--Cartas 3 4 periodo

calculo2 :: Carta
calculo2 = Carta 25 "calculo II" 1400 1000 True  False

haskell :: Carta
haskell  = Carta 26 "Aprender Haskell" 1500 1200 True  False

sono :: Carta
sono  = Carta 27 "Sono na aula" 1100 1000 True  False

colaErrada :: Carta
colaErrada = Carta 28 "cola errada" 1150 1100 True  False

grafos :: Carta
grafos = Carta 29 "Video aula de Grafos" 1250 1100 True  False

linear :: Carta
linear = Carta 30 "Algebra Linear" 1450 800 True  False

eda :: Carta
eda = Carta 31 "EDA" 1200 1000 True  False

repEDA :: Carta
repEDA = Carta 32 "Reposicao de EDA (Dalba não perdoara)" 1200 1500 True  False

leda :: Carta
leda = Carta 33 "LEDA" 1200 1000 True  False

repLEDA :: Carta
repLEDA = Carta 34 "Reposicao de LEDA (Ta ferrado)" 1200 1500 True  False

bd1 :: Carta
bd1 = Carta 35 "Banco de dados 1" 1100 1300 True  False 

preguica :: Carta
preguica = Carta 36 "Preguica" 1500 1200 True  False 

roubo :: Carta
roubo = Carta 37 "Roubo"  1250 1400 True  False 

namoro :: Carta
namoro = Carta 38 "Namoro" 1400 1100 True  False 

sagui :: Carta
sagui = Carta 39 "Sagui" 1400 1500 True  False

luizAntonio :: Carta
luizAntonio = Carta 40 "Professor Luiz Antonio" 1200 1400 True  False

adalberto :: Carta
adalberto = Carta 41 "Tio adalberto" 1450 1100 True  False

killer :: Carta
killer = Carta 42 "Professor killer" 1500 1000 True  False

patriciaDuarte :: Carta
patriciaDuarte = Carta 43 "Professora Patricia Duarte" 1000 1500 True  False

nervosismo :: Carta
nervosismo = Carta 44 "nervosismo" 1500 1300 True  False

campelo :: Carta
campelo = Carta 45 "Professor Claudio Campelo" 1400 1400 True  False

areli :: Carta
areli = Carta 46 "professora Areli" 1100 1200 True  False

rohit :: Carta
rohit = Carta 47 "professor rohit" 1500 1100 True  False

joseane :: Carta
joseane = Carta 48 "professora Joseane" 1200 1500 True  False

elmar :: Carta
elmar = Carta 49 "professor elmar" 1500 1400 True  False

everton :: Carta
everton = Carta 50 "professor Everton" 1300 1500 True  False

melina :: Carta
melina = Carta 51 "professora Melina" 1300 1100 True  False

fabioJorge :: Carta
fabioJorge = Carta 52 "professor Fabio Jorge" 1350 1100 True  False

substituto :: Carta
substituto = Carta 53 "Professor substituto" 1500 1200 True  False

--Cartas 5 6 periodo

crise :: Carta
crise = Carta 54 "A crise do meio do curso" 1650 1600 True  False

ead :: Carta
ead = Carta 55 "o curso agora e EAD" 1900 1800 True  False

prazo :: Carta
prazo = Carta 56 "Trabalho com prazo curto" 1800 1700 True  False

optativasDo6 :: Carta
optativasDo6 = Carta 57 "Escolher as optativa do 6periodo" 1600 1600 True  False

perdido :: Carta
perdido = Carta 58 "Voce esta perdido no curso" 1900 1850 True  False

estatistica :: Carta
estatistica = Carta 59 "Estatistica Aplicada" 1600 1000 True  False

engenhariaSoft :: Carta
engenhariaSoft = Carta 60 "Engenharia de Software" 1700 1300 True  False

repEstatistica :: Carta
repEstatistica = Carta 61 "Reposicao de Estatistica Aplicada" 1700 1000 True  False

repEngenhariaSoft :: Carta
repEngenhariaSoft = Carta 62 "Reposicao de Engenharia de Software" 1800 1300 True  False

iA :: Carta
iA = Carta 63 "Inteligencia Artificial" 1800 1700 True  False

pato :: Carta
pato = Carta 64 "Pato" 1700 1600 True  False

gato :: Carta
gato = Carta 65 "Gato" 2000 1600 True  False 

cachorro :: Carta
cachorro =Carta  66 "Cachorro" 1700 2000 True  False 

metodologiaCientifica :: Carta
metodologiaCientifica = Carta 67 "Metodologia cientifica" 1800 1700 True  False 

wifi :: Carta
wifi = Carta 68 "Wi fi" 1600 1900 True  False

desmotivacao :: Carta
desmotivacao = Carta 69 "Desmotivacao" 1600 1600 True  False

depressao :: Carta
depressao = Carta 70 "Depressao" 1950 1875 True  False

cachaca :: Carta
cachaca = Carta 71 "cachaca de oro" 1600 2000 True  False

ritalina :: Carta
ritalina = Carta 72 "ritalina" 2000 1850 True  False

queridinho :: Carta
queridinho = Carta 73 "aluno queridinho pelo prof" 1900 1700 True  False

resiliente :: Carta
resiliente = Carta 74 "aluno resiliente" 2000 2000 True  False

odio :: Carta
odio = Carta 75 "aluno motivado pelo odio" 2020 1600 True  False

--Cartas 7 8 periodo

ressaca :: Carta
ressaca = Carta 76 "Ir para a aula de ressaca" 2100 2200 True  False

trabalhoGrupo :: Carta
trabalhoGrupo = Carta 77 "Trabalho em grupo" 2150 2400 True  False

treta :: Carta
treta = Carta 78 "Treta no lcc2" 2250 2200 True  False

pcQuebrado :: Carta
pcQuebrado = Carta 79 "Seu Pc quebrou, poxa" 2455 2500 True  False

provas3 :: Carta
provas3  = Carta 80 "3 provas no mesmo dia" 2500 2450 True  False

compiladores :: Carta
compiladores = Carta 81 "Compiladores" 2100 1500 True  False

projetoEmComputacao1 :: Carta
projetoEmComputacao1 = Carta 82 "Projeto em computacao 1" 2500 2000 True  False

estagio :: Carta
estagio = Carta 83 "Estagio" 2400 1500 True  False

repCompiladores :: Carta
repCompiladores = Carta 84 "Reposicao de Compiladores" 2200 1500 True  False

sorte :: Carta
sorte = Carta 85 "Sorte" 2100 2200 True  False 

amizade :: Carta
amizade = Carta 86 "Amizade" 2400 2200 True  False 

vicio :: Carta
vicio = Carta 87 "Vicio" 2500 2100 True  False 

iguana :: Carta
iguana = Carta 88 "Iguana" 2200 2500 True  False 

dorDeCabeca :: Carta
dorDeCabeca = Carta 89 "Dor de cabeca" 2300 2000 True  False

cheirado :: Carta
cheirado = Carta 90 "aluno cheirador (aspirador fica pra traz)" 2400 2250 True  False

louco :: Carta
louco = Carta 91 "aluno que adquiriu loucura ao longo do tempo, mas uma genialidade incrivel" 2501 2100 True  False

brasileiro :: Carta
brasileiro = Carta 92 "professor Francisco Brasileiro" 2500 2200 True  False

resistente :: Carta
resistente = Carta 93 "aluno que apesar das adversidades persistiu ate agora" 2400 2300 True  False

mutante :: Carta
mutante = Carta 94 "aluno que sofreu mutacoes devido a exposicao demasiada a radiacao no lcc2" 2100 2100 True  False

gaudencioPossesso :: Carta
gaudencioPossesso = Carta 95 "professor gaudencio possuido por espirito de ira" 2505 2500 True  False

--Cartas 9 periodo

colacao :: Carta
colacao = Carta 95 "colacao de grau " 2700 2450 True  False

formaturaCara :: Carta
formaturaCara = Carta 97 "formatura o zoi da Cara" 2800 2600 True  False

tcc :: Carta
tcc = Carta 98 "Compiladores" 1000 3000 True  False 

projetoEmComputacao2 :: Carta
projetoEmComputacao2 = Carta 99 "Projeto em computacao 2" 2700 2000 True  False 

emprego :: Carta
emprego = Carta 100 "Emprego" 2900 2500 True  False

laguinho :: Carta
laguinho = Carta 101 "Laguinho" 2500 2700 True  False

greve :: Carta
greve = Carta 102 "Greve" 2700 2600 True  False

fimDoMundo :: Carta
fimDoMundo = Carta 103 "Fim do Mundo" 2900 2600 True  False

insonia :: Carta
insonia = Carta 104 "Insonia" 2700 2500 True  False 

jacare :: Carta
jacare = Carta 105 "Jacare" 2800 2700 True  False 

procurandoEmprego :: Carta
procurandoEmprego = Carta 106 "aluno procurando emprego antes de se formar" 2600 2900 True  False

poliglota :: Carta
poliglota = Carta 107 "aluno poliglota" 2950 2700 True  False

genioMaster :: Carta
genioMaster = Carta 108 "aluno contratado como dev pleno sem nunca ter trabalhado" 3050 2900 True  False

falheiEmTudo :: Carta
falheiEmTudo = Carta 109 "aluno que fracassou em tudo e adiquiriu resistencias incriveis" 2600 3000 True  False

