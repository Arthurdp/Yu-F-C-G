data Carta = Carta {
    nome :: String,
    ataque :: Int,
    defesa :: Int,
    modoAtaque :: Bool,
    tipo :: String
} deriving (Show)


--Cartas Tipo Equipamento de Aluno

colinha :: Carta
colinha = Carta "Colinha" 400 400 True "Equip"

virote :: Carta
virote = Carta "Virote" 600 100 True "Equip"

dicaProf :: Carta
dicaProf = Carta "Dica do professor na prova" 1000 1000 True "Equip"

--Cartas Tipo Aluno

aluno1Periodo :: Carta
aluno1Periodo = Carta "Aluno do primeiro período" 600 400 True "Aluno"

aluno2Periodo :: Carta
aluno2Periodo = Carta "Aluno do Segundo período" 600 400 True "Aluno"

aluno3Periodo :: Carta
aluno3Periodo = Carta "Aluno do Terceiro período" 600 400 True "Aluno"

aluno4Periodo :: Carta
aluno4Periodo = Carta "Aluno do Quarto período" 600 400 True "Aluno"

aluno5Periodo :: Carta
aluno5Periodo = Carta "Aluno do Quinto período" 600 400 True "Aluno"

aluno6Periodo :: Carta
aluno6Periodo = Carta "Aluno do Sexto período" 600 400 True "Aluno"

aluno7Periodo :: Carta
aluno7Periodo = Carta "Aluno do Sétimo período" 600 400 True "Aluno"

aluno8Periodo :: Carta
aluno8Periodo = Carta "Aluno do Oitavo período" 600 400 True "Aluno"

aluno9Periodo :: Carta
aluno9Periodo = Carta "Aluno do Nono período" 600 400 True "Aluno"

alunoFormado :: Carta
alunoFormado = Carta "Aluno formado, o mais Poderoso" 600 400 True "Aluno"

--Cartas Monstro 1 2 periodo

reposicaoProgramacao1 :: Carta
reposicaoProgramacao1 = Carta "Reposição Programação 1" 700 500 True "Monstro"

programacao2 :: Carta
programacao2 = Carta "Programação 2" 800 500 True "Monstro"

reposicaoProgramacao2 :: Carta
reposicaoProgramacao2 = Carta "Reposição Programação 2" 900 600 True "Monstro"

monitorProgramacao1 :: Carta
monitorProgramacao1 = Carta "Monitor de Programação 1" 800 400 True "Monstro"

monitorProgramacao2 :: Carta
monitorProgramacao2 = Carta "Monitor de Programação 2" 800 400 True "Monstro"

--Cartas Monstro 3 4 periodo

linear :: Carta
linear = Carta "Algebra Linear" 1300 800 True "Monstro"

eda :: Carta
eda = Carta "EDA" 1200 1000 True "Monstro"

reposicaoEDA :: Carta
reposicaoEDA = Carta "Reposição de EDA (Dalba não perdoará)" 1500 1200 True "Monstro"

leda :: Carta
leda = Carta "LEDA" 1200 1000 True "Monstro"

reposicaoLEDA :: Carta
reposicaoLEDA = Carta "Reposição de LEDA (Tá ferrado)" 1500 1200 True "Monstro"

--Cartas Monstro 5 6 periodo

estatistica :: Carta
estatistica = Carta "Estatística Aplicada" 1600 1000 True "Monstro"

engenhariaSoft :: Carta
engenhariaSoft = Carta "Engenharia de Software" 1700 1300 True "Monstro"