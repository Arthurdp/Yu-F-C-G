module CartasArthur where

type Id = Int
type Nome = String
type Ataque = Int
type Defesa = Int
type ModoAtaque = Bool
type Equips = [Carta]

data Carta = Equipamento Id Nome Ataque Defesa | Aluno Id Nome Ataque Defesa ModoAtaque Equips | Monstro Id Nome Ataque Defesa ModoAtaque | Vazia Id
 deriving (Show)

selecId :: Carta -> Int
selecId (Equipamento id _ _ _) = id
selecId (Aluno id _ _ _ _ _) = id
selecId (Monstro id _ _ _ _) = id
selecId (Vazia id) = id

--Carta vazia

cartaVazia :: Carta
cartaVazia = Vazia 00

--Cartas Tipo Equipamento de Aluno

colinha :: Carta
colinha = Equipamento 34 "Colinha" 400 400 

virote :: Carta
virote = Equipamento 35 "Virote" 600 100 

dicaProf :: Carta
dicaProf = Equipamento 36 "Dica do professor na prova" 1000 1000 

--Cartas Tipo Aluno

aluno1Periodo :: Carta
aluno1Periodo = Aluno 01 "Aluno do primeiro período" 500 400 True []

aluno2Periodo :: Carta
aluno2Periodo = Aluno 02 "Aluno do Segundo período" 700 500 True []

aluno3Periodo :: Carta
aluno3Periodo = Aluno 03 "Aluno do Terceiro período" 1000 800 True []

aluno4Periodo :: Carta
aluno4Periodo = Aluno 04 "Aluno do Quarto período" 1200 1000 True []

aluno5Periodo :: Carta
aluno5Periodo = Aluno 05 "Aluno do Quinto período" 1500 1400 True []

aluno6Periodo :: Carta
aluno6Periodo = Aluno 06 "Aluno do Sexto período" 1700 1500 True []

aluno7Periodo :: Carta
aluno7Periodo = Aluno 07 "Aluno do Sétimo período" 2000 1800 True []

aluno8Periodo :: Carta
aluno8Periodo = Aluno 08 "Aluno do Oitavo período" 2200 1900 True []

aluno9Periodo :: Carta
aluno9Periodo = Aluno 09 "Aluno do Nono período" 2500 2100 True []

alunoFormado :: Carta
alunoFormado = Aluno 10 "Aluno formado, o mais Poderoso" 2700 2500 True []

--Cartas Monstro 1 2 periodo

repProgramacao1 :: Carta
repProgramacao1 = Monstro 12 "Reposição Programação 1" 700 500 True

programacao2 :: Carta
programacao2 = Monstro 13 "Programação 2" 800 500 True

repProgramacao2 :: Carta
repProgramacao2 = Monstro 14 "Reposição Programação 2" 900 600 True

monitorProgramacao1 :: Carta
monitorProgramacao1 = Monstro 15 "Monitor de Programação 1" 800 400 True

monitorProgramacao2 :: Carta
monitorProgramacao2 = Monstro 16 "Monitor de Programação 2" 1000 400 True

--Cartas Monstro 3 4 periodo

linear :: Carta
linear = Monstro 17 "Algebra Linear" 1300 800 True

eda :: Carta
eda = Monstro 18 "EDA" 1200 1000 True

repEDA :: Carta
repEDA = Monstro 19 "Reposição de EDA (Dalba não perdoará)" 1200 1500 True

leda :: Carta
leda = Monstro 20 "LEDA" 1200 1000 True

repLEDA :: Carta
repLEDA = Monstro 21 "Reposição de LEDA (Tá ferrado)" 1200 1500 True

--Cartas Monstro 5 6 periodo

estatistica :: Carta
estatistica = Monstro 22 "Estatística Aplicada" 1600 1000 True

engenhariaSoft :: Carta
engenhariaSoft = Monstro 23 "Engenharia de Software" 1700 1300 True

repEstatistica :: Carta
repEstatistica = Monstro 24 "Reposição de Estatística Aplicada" 1700 1000 True

repEngenhariaSoft :: Carta
repEngenhariaSoft = Monstro 25 "Reposição de Engenharia de Software" 1800 1300 True

iA :: Carta
iA = Monstro 26 "Inteligência Artificial" 1800 1700 True

--Cartas Monstro 7 8 periodo

compiladores :: Carta
compiladores = Monstro 27 "Compiladores" 2000 1500 True

projetoEmComputacao1 :: Carta
projetoEmComputacao1 = Monstro 28 "Projeto em computação 1" 2500 2000 True

estagio :: Carta
estagio = Monstro 29 "Estágio" 2400 1500 True

repCompiladores :: Carta
repCompiladores = Monstro 30 "Reposição de Compiladores" 2200 1500 True

--Cartas Monstro 9 periodo

tcc :: Carta
tcc = Monstro 31 "Compiladores" 1000 3000 True 

projetoEmComputacao2 :: Carta
projetoEmComputacao2 = Monstro 32 "Projeto em computação 2" 2700 2000 True 

emprego :: Carta
emprego = Monstro 33 "Emprego" 2900 2500 True