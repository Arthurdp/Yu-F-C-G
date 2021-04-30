module Batalha where

import GHC.IO.Encoding
import System.IO.Unsafe
import Cartas
import Deck
import AtaqueInimigo
import Menu

main :: IO()
main = do
    setLocaleEncoding utf8
    input1 <- getLine
    let deck = [pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA]
    let mao = [pato, iA, pato, iA, pato]
    printcampo mao mao mao


periodo1 :: Jogador
periodo1 = "Primeiro Período" [] [pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA, pato, iA] 8000 [] [] []


draw :: [Carta] -> [Carta]
draw deck = take 1 (reverse deck)

geraMao :: [Carta] -> [Carta]
geraMao deck = take 5 (reverse deck)

geraMao4 :: [Carta] -> [Carta]
geraMao deck = take 4 (reverse deck)

batalha :: Jogador -> Jogador -> IO Jogador
batalha jogador oponente = do
    let deckEmbaralhadoJogador = geraDeckEmbaralhado (deck jogador)
    let deckEmbaralhadoOponente = geraDeckEmbaralhado (deck oponente)
    let jogadorBatalha = (nomeJogador jogador) (colecao jogador) deckEmbaralhadoJogador (vida jogador) (geraMao deckEmbaralhadoJogador) (replicate 5 cartaVazia) (derrotados jogador)
    let oponenteBatalha = (nomeJogador oponente) (colecao oponente) deckEmbaralhadoOponente (vida oponente) (geraMao4 deckEmbaralhadoOponente) (replicate 5 cartaVazia) (derrotados oponente)

    printCampo (vida jogadorBatalha) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    menuInvocaCartas jogadorBatalha oponenteBatalha
    cartaInvoc <- getLine
    let cartaInvocMao = (!! cartaInvoc (mao jogadorBatalha))
    let jogadorBatalha2 = (nomeJogador jogadorBatalha) (colecao jogadorBatalha) deckEmbaralhadoJogador (vida jogadorBatalha) (removeCarta (iD cartaInvocMao jogadorBatalha)) (addCarta (iD cartaInvoc) (removeCarta (iD cartaVazia) cartasCampo jogadorBatalha)) (derrotados jogadorBatalha)

    printCampo (vida jogadorBatalha2) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogadorBatalha2) (mao jogadorBatalha2)
    batalhaOponente jogadorBatalha2 oponenteBatalha

batalhaRecursiva :: Jogador -> Jogador -> IO Jogador
batalhaRecursiva jogador oponente = do
    let jogadorBatalha = (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (addCarta (iD (draw (deck jogador))) (deck jogador) (mao jogador)) (cartasCampo jogador) (derrotados jogador)
    menuBatalha jogadorBatalha oponente
    

menuBatalha :: Jogador -> Jogador -> IO Jogador
menuBatalha jogador oponente = do
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    menuInvocaCartas jogador oponente
    cartaInvoc <- getLine
    let jogadorBatalha = (nomeJogador jogador) (colecao jogador) deckEmbaralhadoJogador (vida jogador) (addCartaVazia (removeCarta (iD cartaInvocMao jogador))) (addCarta (iD cartaInvoc) (removeCarta (iD cartaVazia) cartasCampo jogadorBatalha)) (derrotados jogador)
    printCampo (vida jogadorBatalha) (vida jogadorBatalha) (cartasCampo jogadorBatalha) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    menuAtaque jogadorBatalha oponente

menuAtaque :: Jogador -> Jogador -> IO Jogador
menuAtaque jogador oponente = do
    printMenuAtaque jogador
    indexCartaJogador <- getLine 
    let cartaJogador = (!! indexCartaJogador (cartasCampo jogador))
    printMenuAtaqueOponente oponente
    indexCartaOponente <- getLine 
    let cartaOponente = (!! indexCartaOponente (cartasCampo jogador))
    if indexCartaJogador == 6 then batalhaOponente jogador oponente
    else
        batalhaCartas jogador oponente cartaJogador cartaOponente

batalhaOponente :: Jogador -> Jogador -> IO Jogador
batalhaOponente jogador oponente = do
    let jogadorAtacou = (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (resetaAtacou (cartasCampo jogador)) (derrotados jogador)
    let oponente1 = (nomeJogador oponente) (colecao oponente) (deck oponente) (vida oponente) (addCarta (iD (draw (deck oponente))) (deck oponente) (mao oponente)) (cartasCampo oponente) (derrotados oponente)
    let cartaInvoc = logicaInvoc oponente1
    let oponente2 = (nomeJogador oponente) (colecao oponente) (deck oponente) (vida oponente) (addCartaVazia (removeCarta (iD cartaInvoc) mao oponente)) (cartasCampo oponente) (derrotados oponente)
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    ataqueOponente

ataqueOponente :: Jogador -> Jogador -> IO Jogador
ataqueOponente jogador oponente = do
    let cartaDerrotada = logicaAtaque
    if (iD cartaDerrotada) == 00 then batalhaRecursiva jogador oponente
    else ataqueOponente 

-- Coloca a lógica de ataque aqui



logicaInvoc :: Jogador -> Carta
logicaInvoc oponente = do
    let ataqueForte = ataqueMaisForte (mao oponente)
    let defesaForte = defesaMaisForte (mao jogador)
    let cartaAtaque = achaAtaqueMaisForte (mao oponente)
    let cartaDefesa = achaDefesaMaisForte (mao oponente)
    if ataque >= defesa then cartaAtaque 
    else
        cartaDefesa

batalhaCartas :: Jogador -> Jogador -> Carta -> Carta -> IO Jogador
batalhaCartas jogador oponente cartaAtacante cartaAtacada  
    | not (modoAtaque cartaAtacante) = erroCartaEmDefesa
    | not (atacou cartaAtacante) = erroCartaAtacou
    | (modoAtaque cartaAtacada) = batalhaCartasAtaque jogador oponente cartaAtacante cartaAtacada
    | otherwise = batalhaCartasDefesa jogador oponente cartaAtacante cartaAtacada

erroCartaEmDefesa :: Jogador -> Jogador -> IO Jogador
erroCartaEmDefesa jogador oponente = do
    putStrLn  "Carta em modo de Defesa não pode atacar... escolha novamente"
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    menuAtaque jogador oponente

erroCartaAtacou :: Jogador -> Jogador -> IO Jogador
erroCartaEmDefesa jogador oponente = do
    putStrLn  "A carta que você escolheu já atacou... escolha novamente"
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    menuAtaque jogador oponente

batalhaCartasAtaque :: Jogador -> Jogador -> Carta -> Carta -> IO Jogador
batalhaCartasAtaque jogador oponente cartaAtacante cartaAtacada = do
    let diferenca = calculaDiferenca cartaAtacante cartaAtacada
    let cartaAtacou = alteraStatusAtacouTrue cartaAtacante
    let jogadorAtacou = (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (cartaAtacou ++ (removeCarta (iD cartaAtacou) cartasCampo jogador)) (derrotados jogador)
    if diferenca < 0 then jogadorPerdeAtaque jogador 
    else if diferenca > 0 then jogadorGanhaAtaque oponente
    else empate jogador oponente

alteraStatusAtacouTrue :: Carta -> Carta
alteraStatusAtacouTrue carta = Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) (modoAtaque carta) True  

alteraStatusAtacouFalse :: Carta -> Carta
alteraStatusAtacouFalse carta = Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) (modoAtaque carta) False   

resetaAtacou :: [Carta] -> [Carta]
resetaAtacou (x:xs) = (alteraStatusAtacouFalse x) ++ (resetaAtacou xs)

empate :: Jogador -> Jogador -> IO Jogador
empate jogador oponente = do 
    putStr "As cartas tem o mesmo nível de força e empataram"
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    menuAtaque jogador oponente

jogadorPerdeAtaque :: Jogador -> Jogador -> IO Jogador
jogadorPerdeAtaque jogador oponente carta = do
    putStr "Sua carta perdeu a batalha. Sua carta foi destruída e sua vida diminuiu ;-;"
    let jogadorBatalha = (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) + diferenca) (mao jogador) (addCartaVazia (removeCarta (iD carta) cartasCampo jogador)) (derrotados jogador)
    printCampo (vida jogadorBatalha) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    testaVitoria jogadorBatalha oponente

jogadorGanhaAtaque :: Jogador -> Jogador -> IO Jogador
jogadorGanhaAtaque jogador oponente carta = do
    putStr "Sua carta ganhou a batalha . A carta do oponente foi destruída e a vida dele diminuiu :D"
    let oponenteBatalha = (nomeJogador oponente) (colecao oponente) (deck oponente) ((vida oponente) - diferenca) (mao oponente) (addCartaVazia (removeCarta (iD carta) cartasCampo oponente)) (derrotados oponente)
    printCampo (vida jogador) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogador) (mao jogador)
    testaVitoria jogador oponenteBatalha

batalhaCartasDefesa :: Jogador -> Jogador -> Carta -> Carta -> Carta
batalhaCartasDefesa jogador oponente cartaAtacante cartaAtacada = do
    let diferenca = calculaDiferenca cartaAtacante cartaAtacada
    let cartaAtacou = alteraStatusAtacouTrue cartaAtacante
    let jogadorAtacou = (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (cartaAtacou ++ (removeCarta (iD cartaAtacou) cartasCampo jogador)) (derrotados jogador)
    if diferenca < 0 then jogadorPerdeDefesa jogador 
    else if diferenca > 0 then jogadorGanhaDefesa oponente
    else empate 

jogadorPerdeDefesa :: Jogador -> Jogador -> IO Jogador
jogadorPerdeDefesa jogador oponente carta = do
    putStr "Sua carta perdeu a batalha. Sua vida diminuiu ;-;"
    let jogadorBatalha = (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) + diferenca) (mao jogador) (cartasCampo jogador) (derrotados jogador)
    printCampo (vida jogadorBatalha) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    testaVitoria jogadorBatalha oponente

jogadorGanhaDefesa :: Jogador -> Jogador -> IO Jogador
jogadorGanhaDefesa jogador oponente carta = do
    putStr "Sua carta ganhou a batalha . A vida do oponente diminuiu :D"
    let oponenteBatalha = (nomeJogador oponente) (colecao oponente) (deck oponente) (vida oponente) (mao oponente) (addCartaVazia (removeCarta (iD carta) cartasCampo oponente)) (derrotados oponente)
    printCampo (vida jogador) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogador) (mao jogador)
    testaVitoria jogador oponenteBatalha

calculaDiferenca :: Int -> Int -> Int
calculaDiferenca cartaAtacante cartaAtacada = cartaAtacante - cartaAtacada

testaVitoria :: Jogador -> Jogador -> IO Jogador
testeViroria jogador oponente= do
    if (vida jogador) == 0 then printLoose 
    else if (vida oponente) == 0 then printWin
    else 
        menuAtaque jogador oponente

ataqueMaisForte :: [Carta] -> Int
ataqueMaisForte [] = 0
ataqueMaisForte (x:xs) = max (ataque x) (ataqueMaisForte xs)

achaAtaqueMaisForte :: [Carta] -> Int -> Carta
ataqueMaisForte (x:xs) n
 |ataque x == n = x
 |otherwise = ataqueMaisForte xs n

defesaMaisForte :: [Carta] -> Int
defesaMaisForte [] = 0
defesaMaisForte (x:xs) = max (defesa x) (defesaMaisForte xs)

achaDefesaMaisForte :: [Carta] -> Int -> Carta
achaDefesaMaisForte (x:xs) n
 |defesa x == n = x
 |otherwise = defesaMaisForte xs n

addCartaVazia :: [Carta] -> [Carta]
addCartaVazia lista = cartaVazia ++ lista

menuInvocaCartas :: Jogador -> Jogador -> IO()
menuInvocaCartas jogador oponente = do
    printMenuInvocaCartas
    putStrLn "\n\n \
    \\n #-----------Menu de Invocação-----------#\n\
    \\n\n\
    \\n #-----------Estas são as cartas da sua mão-----------#\n\
    \\n"
    "\n[1] -> " ++ repCarta (!! 0 (mao jogador))
    "\n[2] -> " ++ repCarta (!! 1 (mao jogador))
    "\n[3] -> " ++ repCarta (!! 2 (mao jogador))
    "\n[4] -> " ++ repCarta (!! 3 (mao jogador))
    "\n[5] -> " ++ repCarta (!! 4 (mao jogador))
    ++ "\n\n \
    \\n\nDigite sua escolha: "


printMenuAtaque :: Jogador -> IO()
printMenuAtaque jogador = do
    putStrLn "\n\n \
    \\n #-----------Menu de Ataque-----------#\n\
    \\n\n\
    \\n #-----------Estas são as cartas do seu campo-----------#\n\
    \\n"
    "\n[1] -> " ++ repCarta (!! 0 (cartasCampo jogador))
    "\n[2] -> " ++ repCarta (!! 1 (cartasCampo jogador))
    "\n[3] -> " ++ repCarta (!! 2 (cartasCampo jogador))
    "\n[4] -> " ++ repCarta (!! 3 (cartasCampo jogador))
    "\n[5] -> " ++ repCarta (!! 4 (cartasCampo jogador))
    ++ "\n\
    \\n [6] -> Terminar turno\
    \\n\nEscolha uma carta: "

printMenuAtaqueOponente :: Jogador -> IO()
printMenuAtaqueOponente oponente = do
    putStrLn "\n\n \
    \\n #-----------Menu de Ataque-----------#\n\
    \\n\n\
    \\n #-----------Estas são as cartas do campo do oponente-----------#\n\
    \\n"
    "\n[1] -> " ++ repCarta (!! 0 (cartasCampo oponente))
    "\n[2] -> " ++ repCarta (!! 1 (cartasCampo oponente))
    "\n[3] -> " ++ repCarta (!! 2 (cartasCampo oponente))
    "\n[4] -> " ++ repCarta (!! 3 (cartasCampo oponente))
    "\n[5] -> " ++ repCarta (!! 4 (cartasCampo oponente))
    ++ "\n\n \
    \\n\nEscolha uma carta para atacar, se não houver cartas ataque diretamente: "



printLoose :: Jogador -> IO Jogador
printLoose jogador = do
    putStrLn "\n-----------You Loose------------\n"
    menu jogador

printWin :: Jogador -> IO Jogador
printWin jogador = do
    putStrLn "\n------------You Win-------------\n"
    let jogadorWin = -- add drops Will
    menu jogador

printLinhaCartas :: [Carta] -> String
printLinhaCartas [] = ""
printLinhaCartas (x:xs)
    | iD x == 00 = "|  "++ "xxx" ++ "   |" ++ printLinhaCartas xs
    | iD x < 10 = "|  "++ show(iD x) ++ "    |" ++ printLinhaCartas xs
    | iD x < 100 = "|  "++ show(iD x) ++ "    |" ++ printLinhaCartas xs
    | otherwise = "|  "++ show(iD x) ++ "  |" ++ printLinhaCartas xs

printCampo :: Int -> Int -> [Carta] -> [Carta] -> [Carta] ->  String
printCampo vidaJogador vidaOponente cartasOponente cartasJogador mao = do
    putStrLn ("\n\nVida Jogador = " ++ show vidaJogador ++ "\nVida Oponente = " ++ show vidaOponente ++ "\n\n")
    putStrLn printCampoOponente cartasOponente
    putStrLn printCampoJogador cartasJogador
    putStrLn printMao mao

printCampoOponente :: [Carta] -> String
printCampoOponente cartas = "\
\\n--------------Campo de Batalha---------------\
\\n\
\\n|||||||||||||||||||||||||||||||||||||||||||||\
\\n|       ||       ||       ||       ||       |\n"
 ++ printLinhaCartas cartas ++"\
\\n|       ||       ||       ||       ||       |\
\\n|||||||||||||||||||||||||||||||||||||||||||||"

printCampoJogador :: [Carta] -> String
printCampoJogador cartas = "\
\\n|||||||||||||||||||||||||||||||||||||||||||||\
\\n|       ||       ||       ||       ||       |\n"
 ++ printLinhaCartas cartas ++"\
\\n|       ||       ||       ||       ||       |\
\\n|||||||||||||||||||||||||||||||||||||||||||||"

printMao :: [Carta] -> String
printMao cartas = "\
\\n-------------------Sua Mão-------------------\
\\n\
\\n|||||||||||||||||||||||||||||||||||||||||||||\
\\n|       ||       ||       ||       ||       |\n"
 ++ printLinhaCartas cartas ++"\
\\n|       ||       ||       ||       ||       |\
\\n|||||||||||||||||||||||||||||||||||||||||||||"