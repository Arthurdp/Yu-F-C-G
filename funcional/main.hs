module Main where

import GHC.IO.Encoding
import System.IO.Unsafe
import System.Random (randomRIO)
import Menu
import Jogador
import Inimigos
import Cartas

  
main :: IO Jogador
main = do
 setLocaleEncoding utf8
 printLogo
 nome <- getLine
 putStrLn( "\nBem vindo " ++ nome)
 let jog = Jogador nome [] [matematicaBasica, perdeuOnibus, python, fe, repProgramacao1, livia, eanesBenevolente, robertKalley, matematicaBasica, perdeuOnibus, python, fe, repProgramacao1, livia, eanesBenevolente, robertKalley, perdeuOnibus, python, perdeuOnibus,fe] 8000 [] [] []
 mainMenu jog

escolher :: Int -> Jogador -> IO Jogador
escolher n jog
 |n == 1 = do
    let listaPeriodos = [periodo1, periodo2, periodo3, periodo4, periodo5, periodo6, periodo7, periodo8, periodo9]
    batalha jog (unsafePerformIO (analisaFase jog (derrotados jog) listaPeriodos))
 |n == 2 = menuDuelo jog
 |n == 3 = gerenciaDeck jog
 |n == 4 = do 
    putStrLn "ok ne... xau"
    return jog

analisaFase :: Jogador -> [Jogador] -> [Jogador] -> IO Jogador
analisaFase jog derrotados [] = do
       mainMenu jog
analisaFase jog derrotados (x:xs) 
    | meuElem x derrotados = analisaFase jog derrotados xs
    | otherwise = return x

printZerou :: IO()
printZerou = do
    putStrLn "\nParabens!! Você derrotou todos os periodos e se formou. Continue jogando no Free Duel para conseguir todas as cartas, ou selecione 'sair' para sair do jogo\n"
 
mainMenu :: Jogador -> IO Jogador
mainMenu jog = do
 menu
 opcao <- getLine
 escolher (read opcao) jog

menuDuelo :: Jogador -> IO Jogador
menuDuelo jog  = do
    printMenuDuelo
    opcao <- getLine
    let x = read opcao
    escolheOp x jog
      

escolheOp:: Int -> Jogador -> IO Jogador
escolheOp x jog
    |x == 1 && (meuElem periodo1 (derrotados jog)) = batalha jog periodo1
    |x == 2 && (meuElem periodo2 (derrotados jog)) = batalha jog periodo2
    |x == 3 && (meuElem periodo3 (derrotados jog)) = batalha jog periodo3
    |x == 4 && (meuElem periodo4 (derrotados jog)) = batalha jog periodo4
    |x == 5 && (meuElem periodo5 (derrotados jog)) = batalha jog periodo5
    |x == 6 && (meuElem periodo6 (derrotados jog)) = batalha jog periodo6
    |x == 7 && (meuElem periodo7 (derrotados jog)) = batalha jog periodo7
    |x == 8 && (meuElem periodo8 (derrotados jog)) = batalha jog periodo8
    |x == 9 && (meuElem periodo9 (derrotados jog)) = batalha jog periodo9
    |x == 10 = mainMenu jog
    |otherwise = do 
        putStrLn "Opcao indisponivel, ou jogador bloqueado"
        menuDuelo jog

meuElem :: Jogador -> [Jogador] -> Bool
meuElem periodo [] = False
meuElem periodo (x:xs)
    | (nomeJogador x) == nomeJogador periodo = True
    | otherwise = meuElem periodo xs

--- batalha 

draw :: [Carta] -> Carta
draw deck = head (reverse deck)

geraMao :: [Carta] -> [Carta]
geraMao deck = take 5 (reverse deck)

geraMao4 :: [Carta] -> [Carta]
geraMao4 deck = take 4 (reverse deck)

mudaModo :: Carta -> Carta
mudaModo carta 
    | modoAtaque carta = Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) False (atacou carta)
    | otherwise = Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) True (atacou carta)

mudaModoDefesa :: Carta -> Carta
mudaModoDefesa carta =
    Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) False (atacou carta)

tudoDefesa :: [Carta] -> [Carta]
tudoDefesa [] = []
tudoDefesa (x:xs) 
    | modoAtaque x && not (atacou x) = (mudaModoDefesa x) : (tudoDefesa xs)
    | otherwise = x : tudoDefesa xs

batalha :: Jogador -> Jogador -> IO Jogador
batalha jogador oponente = do
    let deckEmbaralhadoJogador = geraDeckEmbaralhado (deck jogador)
    let deckEmbaralhadoOponente = concat (replicate 2 (geraDeckEmbaralhado (deck oponente)))
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) deckEmbaralhadoJogador (vida jogador) (geraMao deckEmbaralhadoJogador) (replicate 5 cartaVazia) (derrotados jogador)
    let oponenteBatalha = Jogador (nomeJogador oponente) (colecao oponente) deckEmbaralhadoOponente (vida oponente) (geraMao4 deckEmbaralhadoOponente) (replicate 5 cartaVazia) (derrotados oponente)

    printCampo (vida jogadorBatalha) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    menuInvocaCartas jogadorBatalha oponenteBatalha
    cartaInvoc <- getLine
    let cartaInvocMao = (mao jogadorBatalha) !! ((read cartaInvoc) -1)
    
    printMenuModo
    op <- getLine
    let cartaInvocMao2 = mudaModoInvoc (read op) cartaInvocMao 
    
    let jogadorBatalha2 = Jogador (nomeJogador jogadorBatalha) (colecao jogadorBatalha) (deck jogadorBatalha) (vida jogadorBatalha) (removeCarta (iD cartaInvocMao2) (mao jogadorBatalha)) (addCarta (iD cartaInvocMao2) (mao jogadorBatalha) (removeCarta (iD cartaVazia) (cartasCampo jogadorBatalha))) (derrotados jogadorBatalha)
    printCampo (vida jogadorBatalha2) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogadorBatalha2) (mao jogadorBatalha2)
    batalhaOponente jogadorBatalha2 oponenteBatalha

batalhaRecursiva :: Jogador -> Jogador -> IO Jogador
batalhaRecursiva jogador oponente = do
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) (removeCarta (iD (draw(deck jogador))) (deck jogador)) (vida jogador) (addCarta (iD (draw (deck jogador))) (deck jogador) (removeCarta (iD cartaVazia) (mao jogador))) (cartasCampo jogador) (derrotados jogador)
    
    printCampo (vida jogadorBatalha) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    menuInvocaCartas jogadorBatalha oponente
    cartaInvoc <- getLine
    let cartaInvocMao = (mao jogadorBatalha) !! (read cartaInvoc -1)

    printMenuModo
    op <- getLine
    let cartaInvocMao2 = mudaModoInvoc (read op) cartaInvocMao 

    if  (contaNaoVazias(cartasCampo jogadorBatalha)) == 5 then do
        printMenuCartaCheio jogadorBatalha
        indexCartaRetira <- getLine
        let cartaRetira = (cartasCampo jogadorBatalha) !! ((read indexCartaRetira) -1)
        let jogadorBatalha2 = Jogador (nomeJogador jogadorBatalha) (colecao jogadorBatalha) (deck jogadorBatalha) (vida jogadorBatalha) (removeCarta (iD cartaInvocMao2) (mao jogadorBatalha)) (addCarta (iD cartaInvocMao2) (mao jogadorBatalha) (removeCarta (iD cartaRetira) (cartasCampo jogadorBatalha))) (derrotados jogadorBatalha)
        printCampo (vida jogadorBatalha2) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha2) (mao jogadorBatalha2)
        menuBatalha jogadorBatalha2 oponente
    else do
        let jogadorBatalha2 = Jogador (nomeJogador jogadorBatalha) (colecao jogadorBatalha) (deck jogadorBatalha) (vida jogadorBatalha) (removeCarta (iD cartaInvocMao2) (mao jogadorBatalha)) (addCarta (iD cartaInvocMao2) (mao jogadorBatalha) (removeCarta (iD cartaVazia) (cartasCampo jogadorBatalha))) (derrotados jogadorBatalha)
        printCampo (vida jogadorBatalha2) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha2) (mao jogadorBatalha2)
        menuBatalha jogadorBatalha2 oponente
    

printMenuCartaCheio :: Jogador -> IO()
printMenuCartaCheio jogador = do
    putStrLn "Seu campo esta cheio, escolha uma carta para retirar"
    printMenuAtaque jogador

mudaModoInvoc :: Int -> Carta -> Carta
mudaModoInvoc op carta 
    | op == 2 = Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) False (atacou carta)
    | otherwise = carta

menuBatalha :: Jogador -> Jogador -> IO Jogador
menuBatalha jogador oponente = do
    printMenuAtaqueOpcoes
    op <- getLine
    if read op == 1 then do
        printCampo (vida jogador) (vida oponente) (cartasCampo jogador) (cartasCampo oponente) (mao jogador)
        menuAtaque jogador oponente
    else if read op == 2 then do
        menuTrocaModo jogador oponente
    else
        batalhaOponente jogador oponente

menuTrocaModo :: Jogador -> Jogador -> IO Jogador
menuTrocaModo jogador oponente = do
    printMenuAtaque jogador
    indexCartaJogador <- getLine
    let cartaJogador = ((cartasCampo jogador) !! (read indexCartaJogador -1))
    if atacou cartaJogador then do
        putStrLn "Esta carta ja atacou nao pode mais mudar de modo"
        menuTrocaModo jogador oponente
    else do
        let jogadorTroca = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) ((mudaModo (cartasCampo jogador !! read indexCartaJogador)) : (removeCarta (iD ((cartasCampo jogador)!! (read indexCartaJogador))) (cartasCampo jogador))) (derrotados jogador)
        menuBatalha jogadorTroca oponente


menuAtaque :: Jogador -> Jogador -> IO Jogador
menuAtaque jogador oponente = do
    printMenuAtaque jogador
    indexCartaJogador <- getLine
    let cartaJogador = (cartasCampo jogador) !! ((read indexCartaJogador) -1)
    printMenuAtaqueOponente oponente
    indexCartaOponente <- getLine
    let cartaOponente = (cartasCampo oponente) !! ((read indexCartaOponente) -1)
    batalhaCartas jogador oponente cartaJogador cartaOponente

contaNaoVazias :: [Carta] -> Int
contaNaoVazias [] = 0
contaNaoVazias (x:xs)
 | not ((iD x) == 00) = 1 + contaNaoVazias xs
 |otherwise = contaNaoVazias xs

batalhaOponente :: Jogador -> Jogador -> IO Jogador
batalhaOponente jogador oponente = do
    let jogadorAtacou = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (resetaAtacou (cartasCampo jogador)) (derrotados jogador)
    if (contaNaoVazias(cartasCampo oponente)) == 5 then do
        printCampo (vida jogadorAtacou) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorAtacou) (mao jogadorAtacou)
        ataqueOponente jogadorAtacou oponente
    else do 
        let oponente1 = Jogador (nomeJogador oponente) (colecao oponente) (removeCarta (iD (draw (deck oponente))) (deck oponente)) (vida oponente) (addCarta (iD (draw (deck oponente))) (deck oponente) (mao oponente)) (cartasCampo oponente) (derrotados oponente)
        let cartaInvoc = logicaInvoc oponente1
        let oponente2 = Jogador (nomeJogador oponente1) (colecao oponente1) (deck oponente1) (vida oponente1) (addCartaVazia (removeCarta (iD cartaInvoc) (mao oponente1))) (cartaInvoc : (removeCarta (iD cartaVazia)(cartasCampo oponente1))) (derrotados oponente1)
        printCampo (vida jogadorAtacou) (vida oponente2) (cartasCampo oponente2) (cartasCampo jogadorAtacou) (mao jogadorAtacou)
        ataqueOponente jogadorAtacou oponente2


testaCartasAtaqueOponente :: [Carta] -> Jogador -> Jogador -> IO Jogador
testaCartasAtaqueOponente [] jogador oponente = return jogador
testaCartasAtaqueOponente (x:xs) jogador oponente = do 
    let jogadorAtualizado = unsafePerformIO(logicaAtaque x jogador oponente)
    testaCartasAtaqueOponente xs jogadorAtualizado oponente

ataqueOponente :: Jogador -> Jogador -> IO Jogador
ataqueOponente jogador oponente = do
    testaVitoriaOponente (unsafePerformIO (testaCartasAtaqueOponente (cartasCampo oponente) jogador oponente)) oponente

todasAtacou :: [Carta] -> Bool
todasAtacou [] = True
todasAtacou (x:xs)
    | (atacou x) = todasAtacou xs
    | otherwise = False

destroiCartaJogador :: Jogador -> Carta -> Carta -> Jogador
destroiCartaJogador jogador cartaAtacante cartaAtacada = do
    let diferenca = calculaDiferenca (ataque cartaAtacante) (analisaForca cartaAtacada)
    if modoAtaque cartaAtacada then Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) - diferenca) (mao jogador) (addCartaVazia (removeCarta (iD cartaAtacada) (cartasCampo jogador))) (derrotados jogador)
    else
        Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (addCartaVazia (removeCarta (iD cartaAtacada) (cartasCampo jogador))) (derrotados jogador)

analisaForca :: Carta -> Int
analisaForca carta
    |ataque carta > defesa carta = ataque carta
    |otherwise = defesa carta

logicaInvoc :: Jogador -> Carta
logicaInvoc oponente = do
    let ataqueForte = ataqueMaisForte (mao oponente)
    let defesaForte = defesaMaisForte (mao oponente)
    let cartaAtaque = achaAtaqueMaisForte (mao oponente) ataqueForte
    let cartaDefesa = achaDefesaMaisForte (mao oponente) defesaForte
    if ataqueForte >= defesaForte then cartaAtaque
    else
        mudaModoDefesa cartaDefesa

batalhaCartas :: Jogador -> Jogador -> Carta -> Carta -> IO Jogador
batalhaCartas jogador oponente cartaAtacante cartaAtacada = do
    if isCampoVazio (cartasCampo oponente) then do
        let oponenteDireto = Jogador (nomeJogador oponente) (colecao oponente) (deck oponente) (vida oponente - (ataque cartaAtacante)) (mao oponente) (cartasCampo oponente) (derrotados oponente)
        let cartaAtacou = alteraStatusAtacouTrue cartaAtacante
        let jogadorAtacou = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (cartaAtacou : (removeCarta (iD cartaAtacou) (cartasCampo jogador))) (derrotados jogador)
        menuAtaque jogadorAtacou oponenteDireto
    else if (iD cartaAtacada) == 00 then erroCartaVazia jogador oponente
    else if not (modoAtaque cartaAtacante) then erroCartaEmDefesa jogador oponente
    else if not (atacou cartaAtacante) then erroCartaAtacou jogador oponente
    else if modoAtaque cartaAtacada then batalhaCartasAtaque jogador oponente cartaAtacante cartaAtacada
    else
         batalhaCartasDefesa jogador oponente cartaAtacante cartaAtacada

erroCartaVazia :: Jogador -> Jogador -> IO Jogador
erroCartaVazia jogador oponente = do
    putStrLn "Voce nao escolheu uma carta... escolha novamente"
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    menuAtaque jogador oponente

isCampoVazio :: [Carta] -> Bool
isCampoVazio [] = True
isCampoVazio (x:xs)
    | (iD x) == iD cartaVazia = isCampoVazio xs
    | otherwise = False

erroCartaEmDefesa :: Jogador -> Jogador -> IO Jogador
erroCartaEmDefesa jogador oponente = do
    putStrLn  "Carta em modo de Defesa nao pode atacar... escolha novamente"
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    menuAtaque jogador oponente

erroCartaAtacou :: Jogador -> Jogador -> IO Jogador
erroCartaAtacou jogador oponente = do
    putStrLn  "A carta que você escolheu ja atacou... escolha novamente"
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    menuAtaque jogador oponente

batalhaCartasAtaque :: Jogador -> Jogador -> Carta -> Carta -> IO Jogador
batalhaCartasAtaque jogador oponente cartaAtacante cartaAtacada = do
    let diferenca = calculaDiferenca (ataque cartaAtacante) (ataque cartaAtacada)
    let cartaAtacou = alteraStatusAtacouTrue cartaAtacante
    let jogadorAtacou = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (cartaAtacou : (removeCarta (iD cartaAtacou) (cartasCampo jogador))) (derrotados jogador)
    if diferenca < 0 then jogadorPerdeAtaque jogadorAtacou oponente cartaAtacou diferenca
    else if diferenca > 0 then jogadorGanhaAtaque jogadorAtacou oponente cartaAtacou diferenca
    else empateAtq jogador oponente cartaAtacou cartaAtacada

alteraStatusAtacouTrue :: Carta -> Carta
alteraStatusAtacouTrue carta = Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) (modoAtaque carta) True

alteraStatusAtacouFalse :: Carta -> Carta
alteraStatusAtacouFalse carta = Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) (modoAtaque carta) False

resetaAtacou :: [Carta] -> [Carta]
resetaAtacou [] = []
resetaAtacou (x:xs) = (alteraStatusAtacouFalse x) : (resetaAtacou xs)

empateDef :: Jogador -> Jogador -> IO Jogador
empateDef jogador oponente = do
    putStr "As cartas tem o mesmo nivel de forca e empataram, nenhuma foi destruida"
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    menuBatalha jogador oponente

empateAtq :: Jogador -> Jogador -> Carta -> Carta -> IO Jogador
empateAtq jogador oponente cartaAtacante cartaAtacada = do
    putStr "As cartas tem o mesmo nivel de forca e empataram, as duas foram destruidas"
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (addCartaVazia (removeCarta (iD cartaAtacante) (cartasCampo jogador))) (derrotados jogador)
    let oponenteBatalha = Jogador (nomeJogador oponente) (colecao oponente) (deck oponente) (vida oponente) (mao oponente) (addCartaVazia (removeCarta (iD cartaAtacada) (cartasCampo oponente))) (derrotados oponente)
    printCampo (vida jogadorBatalha) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    menuBatalha jogadorBatalha oponenteBatalha

jogadorPerdeAtaque :: Jogador -> Jogador -> Carta -> Int -> IO Jogador
jogadorPerdeAtaque jogador oponente carta diferenca = do
    putStr "Sua carta perdeu a batalha. Sua carta foi destruida e sua vida diminuiu ;-;"
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) + diferenca) (mao jogador) (addCartaVazia (removeCarta (iD carta) (cartasCampo jogador))) (derrotados jogador)
    printCampo (vida jogadorBatalha) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    testaVitoria jogadorBatalha oponente

jogadorGanhaAtaque :: Jogador -> Jogador -> Carta -> Int -> IO Jogador
jogadorGanhaAtaque jogador oponente carta diferenca = do
    putStr "Sua carta ganhou a batalha . A carta do oponente foi destruida e a vida dele diminuiu :D"
    let oponenteBatalha = Jogador (nomeJogador oponente) (colecao oponente) (deck oponente) ((vida oponente) - diferenca) (mao oponente) (addCartaVazia (removeCarta (iD carta) (cartasCampo oponente))) (derrotados oponente)
    printCampo (vida jogador) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogador) (mao jogador)
    testaVitoria jogador oponenteBatalha

batalhaCartasDefesa :: Jogador -> Jogador -> Carta -> Carta -> IO Jogador
batalhaCartasDefesa jogador oponente cartaAtacante cartaAtacada = do
    let diferenca = calculaDiferenca (ataque cartaAtacante) (defesa cartaAtacada)
    let cartaAtacou = alteraStatusAtacouTrue cartaAtacante
    let jogadorAtacou = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (cartaAtacou : (removeCarta (iD cartaAtacou) (cartasCampo jogador))) (derrotados jogador)
    if diferenca < 0 then jogadorPerdeDefesa jogadorAtacou oponente diferenca
    else if diferenca > 0 then jogadorGanhaDefesa jogadorAtacou oponente cartaAtacada
    else empateDef jogadorAtacou oponente

jogadorPerdeDefesa :: Jogador -> Jogador -> Int -> IO Jogador
jogadorPerdeDefesa jogador oponente  diferenca = do
    putStr "Sua carta perdeu a batalha. Sua vida diminuiu ;-;"
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) + diferenca) (mao jogador) (cartasCampo jogador) (derrotados jogador)
    printCampo (vida jogadorBatalha) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    testaVitoria jogadorBatalha oponente

jogadorGanhaDefesa :: Jogador -> Jogador -> Carta -> IO Jogador
jogadorGanhaDefesa jogador oponente carta = do
    putStr "Sua carta ganhou a batalha. A carta do oponente foi destruida"
    let oponenteBatalha = Jogador (nomeJogador oponente) (colecao oponente) (deck oponente) (vida oponente) (mao oponente) (addCartaVazia (removeCarta (iD carta) (cartasCampo oponente))) (derrotados oponente)
    printCampo (vida jogador) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogador) (mao jogador)
    testaVitoria jogador oponenteBatalha

calculaDiferenca :: Int -> Int -> Int
calculaDiferenca cartaAtacante cartaAtacada = cartaAtacante - cartaAtacada

testaVitoria :: Jogador -> Jogador -> IO Jogador
testaVitoria jogador oponente = do
    if (vida jogador) <= 0 then (printLoose jogador)
    else if (vida oponente) <= 0 then (printWin jogador oponente)
    else if length (deck jogador) == 20 then (printLoose jogador)
    else
        menuBatalha jogador oponente

testaVitoriaOponente :: Jogador -> Jogador -> IO Jogador
testaVitoriaOponente jogador oponente = do
    if (vida jogador) <= 0 then (printLoose jogador)
    else if (vida oponente) <= 0 then (printWin jogador oponente)
    else
        batalhaRecursiva jogador oponente


ataqueMaisForte :: [Carta] -> Int
ataqueMaisForte [] = 0
ataqueMaisForte (x:xs) = max (ataque x) (ataqueMaisForte xs)

achaAtaqueMaisForte :: [Carta] -> Int -> Carta
achaAtaqueMaisForte (x:xs) n
 |ataque x == n = x
 |otherwise = achaAtaqueMaisForte xs n

defesaMaisForte :: [Carta] -> Int
defesaMaisForte [] = 0
defesaMaisForte (x:xs) = max (defesa x) (defesaMaisForte xs)

achaDefesaMaisForte :: [Carta] -> Int -> Carta
achaDefesaMaisForte (x:xs) n
 |defesa x == n = x
 |otherwise = achaDefesaMaisForte xs n

addCartaVazia :: [Carta] -> [Carta]
addCartaVazia lista = cartaVazia:lista

menuInvocaCartas :: Jogador -> Jogador -> IO()
menuInvocaCartas jogador oponente = do
    --printMenuInvocaCartas
    putStrLn "\n\n"
    putStrLn "\n #-----------Menu de Invocacao-----------#\n"
    putStrLn "\n\n"
    putStrLn "\n #-----------Estas sao as cartas da sua mao-----------#\n"
    putStrLn "\n"
    putStrLn ("\n[1] -> " ++ repCarta ((mao jogador)!! 0 ))
    putStrLn ("\n[2] -> " ++ repCarta ((mao jogador)!! 1 ))
    putStrLn ("\n[3] -> " ++ repCarta ((mao jogador)!! 2 ))
    putStrLn ("\n[4] -> " ++ repCarta ((mao jogador)!! 3 ))
    putStrLn ("\n[5] -> " ++ repCarta ((mao jogador)!! 4 ))
    putStrLn "\n\n"
    putStrLn "\n\nDigite sua escolha: "

printMenuModo :: IO()
printMenuModo = do
    putStrLn "\n\n"
    putStrLn "\n #-----------Menu de Modo-----------#\n"
    putStrLn "\n\n"
    putStrLn "\n #-----------Qual o modo da carta?-----------#\n"
    putStrLn "\n"
    putStrLn "\n[1] -> Ataque"
    putStrLn "\n[2] -> Defesa"
    putStrLn "\n\n"
    putStrLn "\n\nEscolha uma opcao: "

printMenuAtaqueOpcoes :: IO()
printMenuAtaqueOpcoes = do
    putStrLn "\n\n"
    putStrLn "\n #-----------Menu de Ataque-----------#\n"
    putStrLn "\n\n"
    putStrLn "\n #-----------O que quer fazer?-----------#\n"
    putStrLn "\n"
    putStrLn "\n[1] -> Atacar"
    putStrLn "\n[2] -> Mudar modo de uma carta"
    putStrLn "\n[3] -> Terminar Turno"
    putStrLn "\n\n"
    putStrLn "\n\nEscolha uma opcao: "

printMenuAtaque :: Jogador -> IO()
printMenuAtaque jogador = do
    putStrLn "\n\n"
    putStrLn "\n #-----------Menu de Ataque-----------#\n"
    putStrLn "\n\n"
    putStrLn "\n #-----------Estas sao as cartas do seu campo-----------#\n"
    putStrLn "\n"
    putStrLn ("\n[1] -> " ++ (repCarta (cartasCampo jogador!! 0) ++ repModo (cartasCampo jogador!! 0)))
    putStrLn ("\n[2] -> " ++ (repCarta (cartasCampo jogador!! 1) ++ repModo (cartasCampo jogador!! 1)))
    putStrLn ("\n[3] -> " ++ (repCarta (cartasCampo jogador!! 2) ++ repModo (cartasCampo jogador!! 2)))
    putStrLn ("\n[4] -> " ++ (repCarta (cartasCampo jogador!! 3) ++ repModo (cartasCampo jogador!! 3)))
    putStrLn ("\n[5] -> " ++ (repCarta (cartasCampo jogador!! 4) ++ repModo (cartasCampo jogador!! 4)))
    putStrLn "\n\n"
    putStrLn "\n\nEscolha uma carta: "

repModo :: Carta -> String
repModo carta 
        | modoAtaque carta && iD carta > 00 = " Modo de Ataque"
        | not (modoAtaque carta) && iD carta > 00 = " Modo de Defesa"
        | otherwise = ""

printMenuAtaqueOponente :: Jogador -> IO()
printMenuAtaqueOponente oponente = do
    putStrLn "\n\n"
    putStrLn "\n #-----------Menu de Ataque-----------#\n"
    putStrLn "\n\n"
    putStrLn "\n #-----------Estas sao as cartas do campo do oponente-----------#\n"
    putStrLn "\n"
    putStrLn ("\n[1] -> " ++ (repCarta (cartasCampo oponente!! 0) ++ repModo (cartasCampo oponente!! 0)))
    putStrLn ("\n[2] -> " ++ (repCarta (cartasCampo oponente!! 1) ++ repModo (cartasCampo oponente!! 1)))
    putStrLn ("\n[3] -> " ++ (repCarta (cartasCampo oponente!! 2) ++ repModo (cartasCampo oponente!! 2)))
    putStrLn ("\n[4] -> " ++ (repCarta (cartasCampo oponente!! 3) ++ repModo (cartasCampo oponente!! 3)))
    putStrLn ("\n[5] -> " ++ (repCarta (cartasCampo oponente!! 4) ++ repModo (cartasCampo oponente!! 4)))
    putStrLn "\n\n"
    putStrLn "\n\nEscolha uma carta para atacar, se nao houver cartas ataque diretamente: "



printLoose :: Jogador -> IO Jogador
printLoose jogador = do
    putStrLn "\n-----------You Loose------------\n"
    putStrLn "\n-----------Sua vida chegou a 0 ou suas cartas acabaram------------\n"
    mainMenu jogador

printWin :: Jogador -> Jogador -> IO Jogador
printWin jogador oponente = do
    putStrLn "\n------------------You Win-------------\n"
    let card = verificaOponente oponente
    putStrLn ("\n------------Voce ganhou a carta " ++ repCarta card ++ " -------------\n")
    let jogadorWin = addDrop card jogador oponente
    mainMenu (Jogador (nomeJogador jogadorWin) (colecao jogadorWin) (take 20 (reverse (deck jogadorWin))) (vida jogadorWin) (mao jogadorWin) (cartasCampo jogadorWin) (derrotados jogadorWin))

printLinhaCartas :: [Carta] -> String
printLinhaCartas [] = ""
printLinhaCartas (x:xs)
    | iD x == 00 = "|  "++ "xxx" ++ "   |" ++ printLinhaCartas xs
    | iD x < 10 = "|  "++ show(iD x) ++ "    |" ++ printLinhaCartas xs
    | iD x < 100 = "|  "++ show(iD x) ++ "    |" ++ printLinhaCartas xs
    | otherwise = "|  "++ show(iD x) ++ "  |" ++ printLinhaCartas xs

printCampo :: Int -> Int -> [Carta] -> [Carta] -> [Carta] -> IO()
printCampo vidaJogador vidaOponente cartasOponente cartasJogador mao = do
    putStrLn ("\n\nVida Jogador = " ++ show vidaJogador ++ "\nVida Oponente = " ++ show vidaOponente ++ "\n\n")
    putStrLn (printCampoOponente cartasOponente)
    putStrLn (printCampoJogador cartasJogador)
    putStrLn (printMao mao)

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
\\n-------------------Sua Mao-------------------\
\\n\
\\n|||||||||||||||||||||||||||||||||||||||||||||\
\\n|       ||       ||       ||       ||       |\n"
 ++ printLinhaCartas cartas ++"\
\\n|       ||       ||       ||       ||       |\
\\n|||||||||||||||||||||||||||||||||||||||||||||"

-- Deck

contem :: Int -> [Carta] -> Bool
contem i [] = False
contem i (x:xs)
 |iD x == i = True
 |otherwise = contem i xs

repCarta :: Carta -> String
repCarta x 
    |iD x > 0 = "|id: " ++ (show(iD x)) ++ " | nome: " ++ (nomeCarta x) ++ " | ataque = " ++ (show (ataque x)) ++ " | defesa = " ++ (show (defesa x)) ++ "|"
    |otherwise = "Slot Vazio"

repLista :: [Carta] -> String
repLista [] = ""
repLista (x:xs) = repCarta x ++ "\n" ++ repLista xs

addCarta :: Int -> [Carta] -> [Carta] -> [Carta]
addCarta idCarta [] d = []
addCarta idCarta (x:xs) d
 |iD x == idCarta = x:d
 |otherwise = addCarta idCarta xs d

addCartaDeck :: Int -> Jogador -> Jogador
addCartaDeck idCarta jog = Jogador (nomeJogador jog) (colecao jog) (addCarta idCarta (colecao jog) (deck jog)) 8000 [] [] []

removeCarta :: Int -> [Carta] -> [Carta]
removeCarta idCarta [] = []
removeCarta idCarta (x:xs)
 |idCarta == iD x = xs
 |otherwise = x:removeCarta idCarta xs

removeCartaDeck :: Jogador -> IO Jogador
removeCartaDeck jog = do
 putStrLn "Id da carta: "
 idCarta <- getLine
 let j = Jogador (nomeJogador jog) (colecao jog) (removeCarta (read idCarta) (deck jog)) 8000 [] [] []
 putStrLn "Carta removida do deck!"
 gerenciaDeck j

verificaAdd :: Int -> Jogador -> IO Jogador
verificaAdd i jog
 |not (contem i (colecao jog)) = do
  putStrLn "Voce nao possui esta carta."
  gerenciaDeck jog
 |length (deck jog) >= 20 = do
  putStrLn "Deck cheio, remova uma carta antes de adicionar outra."
  gerenciaDeck jog
 |otherwise = do
  putStrLn "Carta adicionada ao deck"
  gerenciaDeck (addCartaDeck i jog)

adicionaCartaDeck :: Jogador -> IO Jogador
adicionaCartaDeck jog = do
 putStrLn "Id da carta: "
 idCarta <- getLine
 verificaAdd (read idCarta) jog

vizualizaColecaoOp :: String -> Jogador -> IO Jogador
vizualizaColecaoOp op jog
 |op == "1" = adicionaCartaDeck jog
 |op == "2" = gerenciaDeck jog
 |otherwise = do
  putStrLn "opção invalida"
  vizualizaColecao jog

vizualizaColecao :: Jogador -> IO Jogador
vizualizaColecao jog = do
 menuColecao
 putStrLn "Colecao:"
 putStrLn (repLista (colecao jog))
 putStrLn "(1)Adicionar carta ao Deck \n(2)Deck"
 opcao <- getLine
 vizualizaColecaoOp opcao jog

vizualizaDeck :: Jogador -> IO()
vizualizaDeck jog = do
 putStrLn "Esse e seu deck:"
 putStrLn (repLista (deck jog))

verificaVolta :: Jogador -> IO Jogador
verificaVolta jog
 |length(deck jog) < 20 = do
  putStrLn "Deck incompleto, tenha 20 cartas no deck para voltar."
  gerenciaDeck jog
 |otherwise = mainMenu jog

gerenciaDeckOp :: String -> Jogador -> IO Jogador
gerenciaDeckOp op jog
 |op == "1" = vizualizaColecao jog
 |op == "2" = removeCartaDeck jog
 |op == "3" = verificaVolta jog
 |otherwise = do
  putStrLn "opcao invalida"
  gerenciaDeck jog

gerenciaDeck :: Jogador -> IO Jogador
gerenciaDeck jog = do
 menuDeck
 vizualizaDeck jog
 opcao <- getLine
 gerenciaDeckOp opcao jog

 -- ataque inimigo 

ataqueMaisForte1 :: [Carta] -> Int
ataqueMaisForte1 [] = 0
ataqueMaisForte1 (x:xs) = max (ataque x) (ataqueMaisForte1 (xs))

ataqueMaisFortee :: [Carta] -> Carta
ataqueMaisFortee [] = cartaVazia
ataqueMaisFortee (x:xs)
 |ataque x == n = x
 |otherwise = ataqueMaisFortee xs
  where n = ataqueMaisForte1 (x:xs)

defesaMaisForte1 :: [Carta] -> Int
defesaMaisForte1 [] = 0
defesaMaisForte1 (x:xs) = max (defesa x) (defesaMaisForte1 (xs))

defesaMaisFortee :: [Carta] -> Carta
defesaMaisFortee (x:xs)
 |defesa x == n = x
 |otherwise = defesaMaisFortee xs
 where n = defesaMaisForte1 (x:xs)

ataqueMaisFraco1 :: [Carta] -> Int
ataqueMaisFraco1 [] = 4000
ataqueMaisFraco1 (x:xs) = min (ataque x) (ataqueMaisFraco1 (xs))

ataqueMaisFraco :: [Carta] -> Carta
ataqueMaisFraco (x:xs)
 |ataque x == n = x
 |otherwise = ataqueMaisFraco xs
 where n = ataqueMaisFraco1 (x:xs)

defesaMaisFraca1 :: [Carta] -> Int
defesaMaisFraca1 [] = 4000
defesaMaisFraca1 (x:xs) = min (defesa x) (defesaMaisFraca1 (xs))

defesaMaisFraca :: [Carta] -> Carta
defesaMaisFraca (x:xs)
 |defesa x == n = x
 |otherwise = defesaMaisFraca xs
 where n = defesaMaisFraca1 (x:xs)

pegaModoDefesa :: [Carta] -> [Carta]
pegaModoDefesa [] = []
pegaModoDefesa (x:xs)
 |not (modoAtaque x) = (x:(pegaModoDefesa xs))
 |otherwise = pegaModoDefesa xs

pegaModoAtaque :: [Carta] -> [Carta]
pegaModoAtaque [] = []
pegaModoAtaque (x:xs)
 |modoAtaque x = (x:(pegaModoAtaque xs))
 |otherwise = pegaModoAtaque xs

logicaAtaque :: Carta -> Jogador -> Jogador -> IO Jogador
logicaAtaque carta jogador oponente
 |isCampoVazio (cartasCampo jogador) = do 
    let jogadorAtualizado = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) - (ataque carta)) (mao jogador) (cartasCampo jogador) (derrotados jogador)
    printCampo (vida jogadorAtualizado) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorAtualizado) (mao jogadorAtualizado)
    return jogadorAtualizado
 |verificaMenorD carta (cartasCampo jogador) = do 
    let jogadorAtualizado1 = destroiCartaJogador jogador carta (pegaMenorD carta (cartasCampo jogador))
    printCampo (vida jogadorAtualizado1) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorAtualizado1) (mao jogadorAtualizado1)
    return jogadorAtualizado1
 |verificaMenorA carta (cartasCampo jogador) = do 
    let jogadorAtualizado2 = destroiCartaJogador jogador carta (pegaMenorA carta (cartasCampo jogador))
    printCampo (vida jogadorAtualizado2) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorAtualizado2) (mao jogadorAtualizado2)
    return jogadorAtualizado2
 |otherwise = return jogador

verificaMenorD :: Carta -> [Carta]-> Bool
verificaMenorD carta [] = False
verificaMenorD carta (x:xs)
 |((ataque carta) > defesa x) && (not (iD x == 00)) = True
 |otherwise = verificaMenorD carta xs

pegaMenorD :: Carta -> [Carta] -> Carta
pegaMenorD carta (x:xs)
 |((ataque carta) > defesa x) && (not (iD x == 00)) = x
 |otherwise = pegaMenorD carta xs

verificaMenorA :: Carta -> [Carta]-> Bool
verificaMenorA carta [] = False
verificaMenorA carta (x:xs)
 |((ataque carta) > ataque x) && (not (iD x == 00)) = True
 |otherwise = verificaMenorA carta xs

pegaMenorA :: Carta -> [Carta] -> Carta
pegaMenorA carta (x:xs)
 |((ataque carta) > ataque x) && (not (iD x == 001)) = x
 |otherwise = pegaMenorA carta xs

geraDeckEmbaralhado :: [Carta] -> [Carta]
geraDeckEmbaralhado [] = []
geraDeckEmbaralhado cartas = carta:geraDeckEmbaralhado (removeCarta (iD carta) cartas)
    where carta = (cartaAleatoria cartas)

cartaAleatoria :: [Carta] -> Carta
cartaAleatoria lista = (lista !! unsafePerformIO(randomRIO (0, (length lista) - 1)))

-- drops

dropar :: [Carta] -> Carta
dropar lista = do 
  let x = geraDeckEmbaralhado lista
  dropar1 x
  
dropar1 :: [Carta] -> Carta
dropar1 (x:xs) = x
  
verificaOponente :: Jogador -> Carta
verificaOponente op
  |nomeJogador op == "Primeiro periodo" = drops1
  |nomeJogador op == "Segundo periodo" = drops2
  |nomeJogador op == "Terceiro periodo" = drops3
  |nomeJogador op == "Quarto periodo" = drops4
  |nomeJogador op == "Quinto periodo" = drops5
  |nomeJogador op == "Sexto periodo" = drops6
  |nomeJogador op == "Setimo periodo" = drops7
  |nomeJogador op == "Oitavo periodo" = drops8
  |otherwise = drops9

addDrop:: Carta -> Jogador -> Jogador -> Jogador 
addDrop card jog opon = Jogador (nomeJogador jog) (card: (colecao jog)) (deck jog) 8000 [] [] (derrotados jog)

-- 90% 10%
-- 1,2 e 3,4

drops1 :: Carta
drops1 = dropar [sePerdeu, python, fmcc1,fmcc2,calculo1, matematicaBasica, empolgacao, fome, 
  perdeuOnibus,esquecimento, repProgramacao1, programacao2, repProgramacao2,
  monitorProgramacao1, monitorProgramacao2, fe, uniao, conselhoEstudantil, livia,
  galdencioAmansado, joseFernando, eanesBenevolente, robertKalley, zeFuinha, calculo2, haskell, sono]

-- 70% 30%
-- 1,2 e 3,4
drops2 :: Carta
drops2 = dropar [sePerdeu, python, fmcc1,fmcc2,calculo1, matematicaBasica, empolgacao, fome, 
  perdeuOnibus,esquecimento, repProgramacao1, programacao2, repProgramacao2,
  monitorProgramacao1, monitorProgramacao2, fe, uniao, conselhoEstudantil, livia,
  galdencioAmansado, joseFernando, eanesBenevolente, robertKalley, zeFuinha, 
  calculo2, haskell, sono, colaErrada, grafos, linear, eda, repEDA, leda, repLEDA, leda]

-- 90% 10%
-- 3,4 e 5,6
drops3 :: Carta
drops3 = dropar [calculo2, haskell, sono, colaErrada, grafos, linear, eda, repEDA, repLEDA, leda,
 bd1, preguica, roubo, namoro, sagui, luizAntonio, adalberto, killer, 
 patriciaDuarte, nervosismo, campelo, areli, rohit, joseane, elmar, everton, 
 melina, fabioJorge, adalberto, crise, ead, prazo]

-- 70% 30%
-- 3,4 e 5,6
drops4 :: Carta
drops4 = dropar [calculo2, haskell, sono, colaErrada, grafos, linear, eda, repEDA, repLEDA, leda,
 bd1, preguica, roubo, namoro, sagui, luizAntonio, adalberto, killer, 
 patriciaDuarte, nervosismo, campelo, areli, rohit, joseane, elmar, everton, 
 melina, fabioJorge, adalberto, crise, ead, prazo, crise, ead, prazo, optativasDo6, perdido, estatistica, engenhariaSoft, repEstatistica, repEngenhariaSoft,
 iA, pato, gato, cachorro]


-- 90% 10%
-- 5,6 e 7,8
drops5 :: Carta
drops5 = dropar [crise, ead, prazo, optativasDo6, perdido, estatistica, engenhariaSoft, repEstatistica, repEngenhariaSoft,
 iA, pato, gato, cachorro, metodologiaCientifica, wifi, desmotivacao, 
 depressao, cachaca, ritalina, queridinho, resiliente, odio, ressaca, trabalhoGrupo, treta]

-- 70% 30%
-- 5,6 e 7,8
drops6 :: Carta
drops6 = dropar [crise, ead, prazo, optativasDo6, perdido, estatistica, engenhariaSoft, repEstatistica, repEngenhariaSoft,
 iA, pato, gato, cachorro, metodologiaCientifica, wifi, desmotivacao, 
 depressao, cachaca, ritalina, queridinho, resiliente, odio, ressaca, trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1, estagio, 
 repCompiladores, sorte]

-- 90% 10%
-- 7,8 e 9
drops7 :: Carta
drops7 = dropar [ressaca, trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1, estagio, 
 repCompiladores, sorte, amizade, vicio, iguana, dorDeCabeca, cheirado, 
 louco, brasileiro, resistente, mutante, gaudencioPossesso, colacao, tcc] 

-- 70% 30%
-- 7,8 e 9
drops8 :: Carta
drops8 = dropar[ressaca, trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1, estagio, 
 repCompiladores, sorte, amizade, vicio, iguana, dorDeCabeca, cheirado, 
 louco, brasileiro, resistente, mutante, gaudencioPossesso, colacao, tcc,
  colacao, tcc, formaturaCara, projetoEmComputacao2, emprego, laguinho, greve]

-- 60% 40%
-- 9
drops9 :: Carta
drops9 = dropar [colacao, formaturaCara, tcc, projetoEmComputacao2, emprego, laguinho, greve,
 fimDoMundo, insonia, jacare, procurandoEmprego, poliglota, genioMaster, falheiEmTudo, ressaca,
  trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1]