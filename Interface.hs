import GHC.IO.Encoding
import System.IO.Unsafe
import System.Random (randomRIO)
import CartasArthur

main :: IO()
main = do
    setLocaleEncoding utf8
    input1 <- getLine
    let deck = [aluno1Periodo, aluno1Periodo, aluno1Periodo, aluno2Periodo, aluno2Periodo, aluno1Periodo, aluno1Periodo, aluno1Periodo, aluno2Periodo, aluno2Periodo, aluno1Periodo, aluno1Periodo, aluno1Periodo, aluno2Periodo, aluno2Periodo, aluno1Periodo, aluno1Periodo, aluno1Periodo, aluno2Periodo, aluno2Periodo]
    let mao = [aluno1Periodo, aluno1Periodo, aluno1Periodo, aluno2Periodo, aluno2Periodo]
    printcampo mao mao mao mao

geraDeckEmbaralhado :: [Carta] -> [Carta]
geraDeckEmbaralhado = embaralhaDeck unsafePerformIO (randomRIO (1,10 :: Int))

embaralhaDeckDnv :: Int -> [Carta] -> [Carta]
embaralhaDeckDnv 0 cartas = cartas
embaralhaDeckDnv num cartas = embaralhaDeckDnv (num -1) (embaralhaDeck cartasDivididas)
    where cartasDivididas = splitAt 2 cartas

embaralhaDeck1 :: ([Carta], [Carta]) -> [Carta]
embaralhaDeck1 (a, b) = embaralhaDeck2 concat (reverse b)  a
    where cartasDivididas = split 3 cartas

embaralhaDeck2 :: ([Carta], [Carta]) -> [Carta]
embaralhaDeck2 (a, b, c) = concat (reverse b)  a (reverse c)

draw :: [Carta] -> [Carta]
draw deck = take 1 (reverse deck)

geraMao :: [Carta] -> [Carta]
geraMao :: deck = take 5 (reverse deck)

batalha :: Jogador -> IO Jogador
batalha jogador = do
    let deckBatalhaJogador = geraDeckEmbaralhado (deck jogador)
    let maoJogador = geraMao deckBatalhaJogador
    let deckBatalhaOponente = geraDeckEmbaralhado deckOponente
    let maoOponente = geraMao deckBatalhaOponente

    let cartasCampoOponente = replicate 5 cartaVazia
    let cartasCampoJogadorMonstro = replicate 5 cartaVazia
    let cartasCampoJogadorEquip = replicate 5 cartaVazia
    printCampo

printLinhaCartas :: [Carta] -> String
printLinhaCartas [] = ""
printLinhaCartas (x:xs)
    | selecId x == 00 = "|  "++ "xx" ++ "   |" ++ printLinhaCartas xs
    | selecId x < 10 = "|  "++ show(selecId x) ++ "   |" ++ printLinhaCartas xs
    | otherwise = "|  "++ show(selecId x) ++ "  |" ++ printLinhaCartas xs

printCampo :: [Carta] -> String
printCampo cartas = do
    putStrLn printCampoOponente cartas
    putStrLn printCampoJogadorMonstros cartas
    putStrLn printCampoJogadorEquips cartas
    putStrLn printCampoOponente mao

printCampoOponente :: [Carta] -> String
printCampoOponente cartas = "\
\\n------------Campo de Batalha------------\
\\n\
\\n||||||||||||||||||||||||||||||||||||||||\
\\n|      ||      ||      ||      ||      |\
\\n|  xx  ||  xx  ||  xx  ||  xx  ||  xx  |\
\\n|      ||      ||      ||      ||      |\
\\n|--------------------------------------|\
\\n|      ||      ||      ||      ||      |\n"
 ++ printLinhaCartas cartas ++"\
\\n|      ||      ||      ||      ||      |\
\\n||||||||||||||||||||||||||||||||||||||||"

printCampoJogadorMonstros :: [Carta] -> String
printCampoJogadorMonstros cartas = "\
\\n||||||||||||||||||||||||||||||||||||||||\
\\n|      ||      ||      ||      ||      |\n"
 ++ printLinhaCartas cartas ++"\
\\n|      ||      ||      ||      ||      |\
\\n|--------------------------------------|"

printCampoJogadorEquips :: [Carta] -> String
printCampoJogadorEquips cartas = "\
\\n|      ||      ||      ||      ||      |\n"
 ++ printLinhaCartas cartas ++"\
\\n|      ||      ||      ||      ||      |\
\\n||||||||||||||||||||||||||||||||||||||||\n"

printMao :: [Carta] -> String
printMao cartas = "\
\\n-----------------Sua Mão----------------\
\\n\
\\n||||||||||||||||||||||||||||||||||||||||\
\\n|      ||      ||      ||      ||      |\n"
 ++ printLinhaCartas cartas ++"\
\\n|      ||      ||      ||      ||      |\
\\n||||||||||||||||||||||||||||||||||||||||\n"