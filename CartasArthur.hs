data Carta = Carta {
    id :: Int,
    nome :: String,
    ataque :: Int,
    defesa :: Int,
    modoAtaque :: Bool,
    tipo :: String
} deriving (Show)


--Cartas Tipo Equipamento de Aluno

colinha :: Carta
colinha = Carta 34 "Colinha" 400 400 True "Equip"

virote :: Carta
virote = Carta 35 "Virote" 600 100 True "Equip"

dicaProf :: Carta
dicaProf = Carta 36 "Dica do professor na prova" 1000 1000 True "Equip"

--Cartas Tipo Aluno

aluno1Periodo :: Carta
aluno1Periodo = Carta 1 "Aluno do primeiro período" 600 400 True "Aluno"

aluno2Periodo :: Carta
aluno2Periodo = Carta 2 "Aluno do Segundo período" 600 400 True "Aluno"

aluno3Periodo :: Carta
aluno3Periodo = Carta 3 "Aluno do Terceiro período" 600 400 True "Aluno"

aluno4Periodo :: Carta
aluno4Periodo = Carta 4 "Aluno do Quarto período" 600 400 True "Aluno"

aluno5Periodo :: Carta
aluno5Periodo = Carta 5 "Aluno do Quinto período" 600 400 True "Aluno"

aluno6Periodo :: Carta
aluno6Periodo = Carta 6 "Aluno do Sexto período" 600 400 True "Aluno"

aluno7Periodo :: Carta
aluno7Periodo = Carta 7 "Aluno do Sétimo período" 600 400 True "Aluno"

aluno8Periodo :: Carta
aluno8Periodo = Carta 8 "Aluno do Oitavo período" 600 400 True "Aluno"

aluno9Periodo :: Carta
aluno9Periodo = Carta 9 "Aluno do Nono período" 600 400 True "Aluno"

alunoFormado :: Carta
alunoFormado = Carta 10 "Aluno formado, o mais Poderoso" 600 400 True "Aluno"

--Cartas Monstro 1 2 periodo

repProgramacao1 :: Carta
repProgramacao1 = Carta 12 "Reposição Programação 1" 700 500 True "Monstro"

programacao2 :: Carta
programacao2 = Carta 13 "Programação 2" 800 500 True "Monstro"

repProgramacao2 :: Carta
repProgramacao2 = Carta 14 "Reposição Programação 2" 900 600 True "Monstro"

monitorProgramacao1 :: Carta
monitorProgramacao1 = Carta 15 "Monitor de Programação 1" 800 400 True "Monstro"

monitorProgramacao2 :: Carta
monitorProgramacao2 = Carta 16 "Monitor de Programação 2" 800 400 True "Monstro"

--Cartas Monstro 3 4 periodo

linear :: Carta
linear = Carta 17 "Algebra Linear" 1300 800 True "Monstro"

eda :: Carta
eda = Carta 18 "EDA" 1200 1000 True "Monstro"

repEDA :: Carta
repEDA = Carta 19 "Reposição de EDA (Dalba não perdoará)" 1500 1200 True "Monstro"

leda :: Carta
leda = Carta 20 "LEDA" 1200 1000 True "Monstro"

repLEDA :: Carta
repLEDA = Carta 21 "Reposição de LEDA (Tá ferrado)" 1500 1200 True "Monstro"

--Cartas Monstro 5 6 periodo

estatistica :: Carta
estatistica = Carta 22 "Estatística Aplicada" 1600 1000 True "Monstro"

engenhariaSoft :: Carta
engenhariaSoft = Carta 23 "Engenharia de Software" 1700 1300 True "Monstro"

repEstatistica :: Carta
repEstatistica = Carta 24 "Reposição de Estatística Aplicada" 1700 1000 True "Monstro"

repEngenhariaSoft :: Carta
repEngenhariaSoft = Carta 25 "Reposição de Engenharia de Software" 1800 1300 True "Monstro"

iA :: Carta
iA = Carta 26 "Inteligência Artificial" 1800 1700 True "Monstro"

--Cartas Monstro 7 8 periodo

compiladores :: Carta
compiladores = Carta 27 "Compiladores" 2000 1500 True "Monstro"

projetoEmComputacao1 :: Carta
projetoEmComputacao1 = Carta 28 "Projeto em computação 1" 2500 2000 True "Monstro"

estagio :: Carta
estagio = Carta 29 "Estágio" 2400 1500 True "Monstro"

repCompiladores :: Carta
repCompiladores = Carta 30 "Reposição de Compiladores" 2200 1500 True "Monstro"

--Cartas Monstro 9 periodo

tcc :: Carta
tcc = Carta 31 "Compiladores" 3000 2500 True "Monstro"

projetoEmComputacao2 :: Carta
projetoEmComputacao2 = Carta 32 "Projeto em computação 2" 2700 2000 True "Monstro"

emprego :: Carta
emprego = Carta 33 "Emprego" 2900 2500 True "Monstro"