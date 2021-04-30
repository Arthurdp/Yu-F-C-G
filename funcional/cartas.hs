module Cartas where

data Carta = Carta {
    iD :: Int,
    nome :: String,
    ataque :: Int,
    defesa :: Int,
    modoAtaque :: Bool
} deriving (Show)


--Carta vazia

cartaVazia :: Carta
cartaVazia = Carta 0 "carta vazia" 00 00 True

--Cartas 1 2 periodo

sePerdeu :: Carta
sePerdeu = Carta 1 "Se perdeu no Campus" 900 700 True

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

python :: Carta
python = Carta 7 "Aprender python" 700 600 True

fmcc1 :: Carta
fmcc1 = Carta 8 "FUND DE MATEMATICA P/ C.DA COMPUTACAO I" 800 800 True

fmcc2 :: Carta
fmcc2 = Carta 9 "FUND DE MATEMATICA P/ C.DA COMPUTACAO II" 900 900 True

calculo1 :: Carta
calculo1 = Carta 10 "calculo I" 900 850 True

fe :: Carta
fe = Carta 11 "fe" 700 800 True

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

uniao :: Carta
uniao = Carta 17 "uniao" 800 1000 True

conselhoEstudantil :: Carta
conselhoEstudantil = Carta 18 "conselho estudandil" 1000 1000 True

livia :: Carta
livia = Carta 19 "professora livia" 750 1000 True

galdencioAmansado :: Carta
galdencioAmansado = Carta 20 "professor galdencio manso" 900 800 True

joseFernando :: Carta
joseFernando = Carta 21 "professor josé fernando" 950 500 True

eanesBenevolente :: Carta
eanesBenevolente = Carta 22 "eanes em estado de benevolencia" 500 900 True

robertKalley :: Carta
robertKalley = Carta 23 "Professor robertKalley" 500 1000 True

zeFuinha :: Carta
zeFuinha = Carta 24 "aluno ze fuinha" 1050 800 True


--Cartas 3 4 periodo

calculo2 :: Carta
calculo2 = Carta 25 "calculo II" 1400 1000 True

haskell :: Carta
haskell  = Carta 26 "Aprender Haskell" 1500 1200 True

sono :: Carta
sono  = Carta 27 "Sono na aula" 1100 1000 True

colaErrada :: Carta
colaErrada = Carta 28 "cola errada" 1150 1100 True

grafos :: Carta
grafos = Carta 29 "Video aula de Grafos" 1250 1100 True

linear :: Carta
linear = Carta 30 "Algebra Linear" 1450 800 True

eda :: Carta
eda = Carta 31 "EDA" 1200 1000 True

repEDA :: Carta
repEDA = Carta 32 "Reposição de EDA (Dalba não perdoará)" 1200 1500 True

leda :: Carta
leda = Carta 33 "LEDA" 1200 1000 True

repLEDA :: Carta
repLEDA = Carta 34 "Reposição de LEDA (Tá ferrado)" 1200 1500 True

bd1 :: Carta
bd1 = Carta 35 "Banco de dados 1" 1100 1300 True 

preguica :: Carta
preguica = Carta 36 "Preguiça" 1500 1200 True 

roubo :: Carta
roubo = Carta 37 "Roubo"  1250 1400 True 

namoro :: Carta
namoro = Carta 38 "Namoro" 1400 1100 True 

sagui :: Carta
sagui = Carta 39 "Sagui" 1400 1500 True

luizAntonio :: Carta
luizAntonio = Carta 40 "Professor Luiz Antonio" 1200 1400 True

adalberto :: Carta
adalberto = Carta 41 "Tio adalberto" 1450 1100 True

killer :: Carta
killer = Carta 42 "Professor killer" 1500 1000 True

patriciaDuarte :: Carta
patriciaDuarte = Carta 43 "Professora Patricia Duarte" 1000 1500 True

nervosismo :: Carta
nervosismo = Carta 44 "nervosismo" 1500 1300 True

campelo :: Carta
campelo = Carta 45 "Professor Claudio Campelo" 1400 1400 True

areli :: Carta
areli = Carta 46 "professora Areli" 1100 1200 True

rohit :: Carta
rohit = Carta 47 "professor rohit" 1500 1100 True

joseane :: Carta
joseane = Carta 48 "professora Joseane" 1200 1500 True

elmar :: Carta
elmar = Carta 49 "professor elmar" 1500 1400 True

everton :: Carta
everton = Carta 50 "professor Everton" 1300 1500 True

melina :: Carta
melina = Carta 51 "professora Melina" 1300 1100 True

fabioJorge :: Carta
fabioJorge = Carta 52 "professor Fabio Jorge" 1350 1100 True

substituto :: Carta
substituto = Carta 53 "Professor substituto" 1500 1200 True

--Cartas 5 6 periodo

crise :: Carta
crise = Carta 54 "A crise do meio do curso" 1650 1600 True

ead :: Carta
ead = Carta 55 "o curso agora é EAD" 1900 1800 True

prazo :: Carta
prazo = Carta 56 "Trabalho com prazo curto" 1800 1700 True

optativasDo6 :: Carta
optativasDo6 = Carta 57 "Escolher as optativa do 6periodo" 1600 1600 True

perdido :: Carta
perdido = Carta 58 "Você está perdido no curso" 1900 1850 True

estatistica :: Carta
estatistica = Carta 59 "Estatística Aplicada" 1600 1000 True

engenhariaSoft :: Carta
engenhariaSoft = Carta 60 "Engenharia de Software" 1700 1300 True

repEstatistica :: Carta
repEstatistica = Carta 61 "Reposição de Estatística Aplicada" 1700 1000 True

repEngenhariaSoft :: Carta
repEngenhariaSoft = Carta 62 "Reposição de Engenharia de Software" 1800 1300 True

iA :: Carta
iA = Carta 63 "Inteligência Artificial" 1800 1700 True

pato :: Carta
pato = Carta 64 "Pato" 1700 1600 True

gato :: Carta
gato = Carta 65 "Gato" 2000 1600 True 

cachorro :: Carta
cachorro =Carta  66 "Cachorro" 1700 2000 True 

metodologiaCientifica :: Carta
metodologiaCientifica = Carta 67 "Metodologia cientifica" 1800 1700 True 

wifi :: Carta
wifi = Carta 68 "Wi-fi" 1600 1900 True

desmotivacao :: Carta
desmotivacao = Carta 69 "Desmotivacao" 1600 1600 True

depressao :: Carta
depressao = Carta 70 "Depressao" 1950 1875 True

cachaca :: Carta
cachaca = Carta 71 "cachaca de oro" 1600 2000 True

ritalina :: Carta
ritalina = Carta 72 "ritalina" 2000 1850 True

queridinho :: Carta
queridinho = Carta 73 "aluno queridinho pelo prof" 1900 1700 True

resiliente :: Carta
resiliente = Carta 74 "aluno resiliente" 2000 2000 True

odio :: Carta
odio = Carta 75 "aluno motivado pelo odio" 2020 1600 True

--Cartas 7 8 periodo

ressaca :: Carta
ressaca = Carta 76 "Ir para a aula de ressaca" 2100 2200 True

trabalhoGrupo :: Carta
trabalhoGrupo = Carta 77 "Trabalho em grupo" 2150 2400 True

treta :: Carta
treta = Carta 78 "Treta no lcc2" 2250 2200 True

pcQuebrado :: Carta
pcQuebrado = Carta 79 "Seu Pc quebrou, poxa" 2455 2500 True

provas3 :: Carta
provas3  = Carta 80 "3 provas no mesmo dia" 2500 2450 True

compiladores :: Carta
compiladores = Carta 81 "Compiladores" 2100 1500 True

projetoEmComputacao1 :: Carta
projetoEmComputacao1 = Carta 82 "Projeto em computação 1" 2500 2000 True

estagio :: Carta
estagio = Carta 83 "Estágio" 2400 1500 True

repCompiladores :: Carta
repCompiladores = Carta 84 "Reposição de Compiladores" 2200 1500 True

sorte :: Carta
sorte = Carta 85 "Sorte" 2100 2200 True 

amizade :: Carta
amizade = Carta 86 "Amizade" 2400 2200 True 

vicio :: Carta
vicio = Carta 87 "Vício" 2500 2100 True 

iguana :: Carta
iguana = Carta 88 "Iguana" 2200 2500 True 

dorDeCabeca :: Carta
dorDeCabeca = Carta 89 "Dor de cabeça" 2300 2000 True

cheirado :: Carta
cheirado = Carta 90 "aluno cheirador (aspirador fica pra traz)" 2400 2250 True

louco :: Carta
louco = Carta 91 "aluno que adquiriu loucura ao longo do tempo, mas uma genialidade incrivel" 2501 2100 True

brasileiro :: Carta
brasileiro = Carta 92 "professor Francisco Brasileiro" 2500 2200 True

resistente :: Carta
resistente = Carta 93 "aluno que apesar das adversidades persistiu ate agora" 2400 2300 True

mutante :: Carta
mutante = Carta 94 "aluno que sofreu mutacoes devido a exposicao demasiada a radiacao no lcc2" 2100 2100 True

gaudencioPossesso :: Carta
gaudencioPossesso = Carta 95 "professor gaudencio possuido por espirito de ira" 2505 2500 True

--Cartas 9 periodo

colacao :: Carta
colacao = Carta 95 "colação de grau " 2700 2450 True

formaturaCara :: Carta
formaturaCara = Carta 97 "formatura o zoi da Cara" 2800 2600 True

tcc :: Carta
tcc = Carta 98 "Compiladores" 1000 3000 True 

projetoEmComputacao2 :: Carta
projetoEmComputacao2 = Carta 99 "Projeto em computação 2" 2700 2000 True 

emprego :: Carta
emprego = Carta 100 "Emprego" 2900 2500 True

laguinho :: Carta
laguinho = Carta 101 "Laguinho" 2500 2700 True

greve :: Carta
greve = Carta 102 "Greve" 2700 2600 True

fimDoMundo :: Carta
fimDoMundo = Carta 103 "Fim do Mundo" 2900 2600 True

insonia :: Carta
insonia = Carta 104 "Insônia" 2700 2500 True 

jacare :: Carta
jacare = Carta 105 "Jacaré" 2800 2700 True 

procurandoEmprego :: Carta
procurandoEmprego = Carta 106 "aluno procurando emprego antes de se formar" 2600 2900 True

poliglota :: Carta
poliglota = Carta 107 "aluno poliglota" 2950 2700 True

genioMaster :: Carta
genioMaster = Carta 108 "aluno contratado como dev pleno sem nunca ter trabalhado" 3050 2900 True

falheiEmTudo :: Carta
falheiEmTudo = Carta 109 "aluno que fracassou em tudo e adiquiriu resistencias incriveis" 2600 3000 True

