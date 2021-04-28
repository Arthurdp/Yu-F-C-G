module Cartas where

type Id = Int
type Nome = String
type Ataque = Int
type Defesa = Int
type ModoAtaque = Bool
type Equips = [Carta]

data Carta = Carta Id Nome Ataque Defesa ModoAtaque deriving(Show)

--primeiro periodo e segundo
fe = Carta 62 "fe" 700 800 True
uniao = Carta 63 "uniao" 800 1000 True
conselhoEstudantil = Carta 64 "conselho estudandil" 1000 1000 True

livia = Carta 65 "professora livia" 750 1000 True
galdencioAmansado = Carta 66 "professor galdencio manso" 900 800 True
joseFernando = Carta 67 "professor josé fernando" 950 500 True
eanesBenevolente = Carta 68 "eanes em estado de benevolencia" 500 900 True
robertKalley = Carta 69 "Professor robertKalley" 500 1000 True
zeFuinha = Carta 82 "aluno ze fuinha" 1050 800 True

--terceiro periodo e quarto
luizAntonio = Carta 70 "Professor Luiz Antonio" 1200 1400 True
adalberto = Carta 71 "Tio adalberto" 1300 1100
killer = Carta 72 "Professor killer" 1500 1000 True
patriciaDuarte = Carta 73 "Professora Patricia Duarte" 1000 1500
nervosismo = Carta 82 "nervosismo" 1550 1300 True

campelo = Carta 74 "Professor Claudio Campelo" 1100 1400 True
areli = Carta 75 "professora Areli" 1100 1200 True
rohit = Carta 76 "professor rohit" 1500 1100 True
joseane = Carta 77 "professora Joseane" 1200 1500 True
elmar = Carta 78 "professor elmar" 1500 1400 True
everton = Carta 79 "professor Everton" 1300 1500 True
melina = Carta 80 "professora Melina" 1300 1100 True
fabioJorge = Carta 81 "professor Fabio Jorge" 1350 1100 True
adalberto = Carta 82 "Professor Adalberto" 1500 1200 True

--quinto periodo e sexto
desmotivacao = Carta 83 "Desmotivacao" 1600 1600 True
depressao = Carta 84 "Deprecao" 1650 1875 True
cachaca = Carta 85 "cachaca de oro" 1600 2000 True
ritalina = Carta 86 "ritalina" 2000 1850 True
Queridinho = Carta 87 "aluno queridinho pelo prof" 1900 1700 True
resiliente = Carta 88 "aluno resiliente" 2000 2000 True
odio = Carta 89 "aluno motivado pelo odio" 2100 1600 True

-- periodo 7 e 8
cheirado = Carta 90 "aluno cheirador (aspirador fica pra traz)"
louco = Carta 91 "aluno que adquiriu loucura ao longo do tempo, mas uma genialidade incrivel" 2650 2100 True
brasileiro = Carta 92 "professor Francisco Brasileiro" 2500 2200 True
resistente = Carta 93 "aluno que apesar das adversidades persistiu ate agora" 2400 2300 True
mutante = Carta 94 "aluno que sofreu mutacoes devido a exposicao demasiada a radiacao no lcc2" 2100 2100 True
gaudencioPossesso = Carta 95 "professor gaudencio possuido por espirito de ira" 2650 2500 True

--periodo 9
procurandoEmprego = Carta 96 "aluno procurando emprego antes de se formar" 2600 2900 True
poliglota = Carta 97 "aluno poliglota" 2950 2700 True
genioMaster = Carta 98 "aluno contratado como dev pleno sem nunca ter trabalhado" 3050 2900 True
falheiEmTudo = Carta 99 "aluno que fracassou em tudo e adiquiriu resistencias incriveis" 2600 3000 True