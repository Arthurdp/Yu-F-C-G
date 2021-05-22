module Main where

import GHC.IO.Encoding
import System.IO.Unsafe
import System.Random (randomRIO)
import Menu
import Jogador
import Cartas

  
main :: IO Jogador
main = do
 setLocaleEncoding utf8
 printLogo
 nome <- getLine
 putStrLn( "\nBem vindo " ++ nome)
 let jog = Jogador nome [] [fimDoMundo, insonia, jacare, procurandoEmprego, poliglota, genioMaster, falheiEmTudo, fimDoMundo, insonia, jacare, procurandoEmprego, poliglota, genioMaster, falheiEmTudo, fimDoMundo, insonia, jacare, procurandoEmprego, poliglota, genioMaster] 8000 [] [] []
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
       printZerou
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
draw deck = head deck

geraMao :: [Carta] -> [Carta]
geraMao deck = take 5 deck

geraMao4 :: [Carta] -> [Carta]
geraMao4 deck = take 4 deck

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
    
    let deckEmbaralhadoJogador = concat (replicate 2 (geraDeckEmbaralhado (deck jogador)))
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) deckEmbaralhadoJogador (vida jogador) (geraMao deckEmbaralhadoJogador) (replicate 5 cartaVazia) (derrotados jogador)
    let deckEmbaralhadoOponente = take 20 (drop 20 (deck oponente))
    let oponenteBatalha = Jogador (nomeJogador oponente) (colecao oponente) deckEmbaralhadoOponente (vida oponente) (geraMao4 deckEmbaralhadoOponente) (replicate 5 cartaVazia) (derrotados oponente)

    printCampo (vida jogadorBatalha) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    menuInvocaCartas jogadorBatalha oponenteBatalha
    cartaInvoc <- getLine
    let cartaInvocMao = (mao jogadorBatalha) !! ((read cartaInvoc) -1)
    
    let jogadorBatalha2 = Jogador (nomeJogador jogadorBatalha) (colecao jogadorBatalha) (removeCarta (iD cartaInvocMao) (deck jogadorBatalha)) (vida jogadorBatalha) (cartaVazia : (removeCarta (iD cartaInvocMao) (mao jogadorBatalha))) (addCarta (iD cartaInvocMao) (mao jogadorBatalha) (removeCarta (iD cartaVazia) (cartasCampo jogadorBatalha))) (derrotados jogadorBatalha)
    printCampo (vida jogadorBatalha2) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogadorBatalha2) (mao jogadorBatalha2)
    batalhaOponente jogadorBatalha2 oponenteBatalha

batalhaRecursiva :: Jogador -> Jogador -> IO Jogador
batalhaRecursiva jogador oponente = do
    let cartaDraw = draw (deck jogador)
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) (drop 1 (deck jogador)) (vida jogador) (cartaDraw : (removeCarta (iD cartaVazia) (mao jogador))) (cartasCampo jogador) (derrotados jogador)
    
    printCampo (vida jogadorBatalha) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    menuInvocaCartas jogadorBatalha oponente
    cartaInvoc <- getLine
    let cartaInvocMao = (mao jogadorBatalha) !! (read cartaInvoc -1)

    
    

    if  (contaNaoVazias(cartasCampo jogadorBatalha)) == 5 then do
        printMenuCartaCheio jogadorBatalha
        indexCartaRetira <- getLine
        let cartaRetira = (cartasCampo jogadorBatalha) !! ((read indexCartaRetira) -1)
        let jogadorBatalha2 = Jogador (nomeJogador jogadorBatalha) (colecao jogadorBatalha) (deck jogadorBatalha) (vida jogadorBatalha) (cartaVazia : (removeCarta (iD cartaInvocMao) (mao jogadorBatalha))) (addCarta (iD cartaInvocMao) (mao jogadorBatalha) (removeCarta (iD cartaRetira) (cartasCampo jogadorBatalha))) (derrotados jogadorBatalha)
        printCampo (vida jogadorBatalha2) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha2) (mao jogadorBatalha2)
        menuBatalha jogadorBatalha2 oponente
    else do
        let jogadorBatalha2 = Jogador (nomeJogador jogadorBatalha) (colecao jogadorBatalha) (deck jogadorBatalha) (vida jogadorBatalha) (cartaVazia : (removeCarta (iD cartaInvocMao) (mao jogadorBatalha))) (addCarta (iD cartaInvocMao) (mao jogadorBatalha) (removeCarta (iD cartaVazia) (cartasCampo jogadorBatalha))) (derrotados jogadorBatalha)
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
        printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
        menuAtaque jogador oponente
    else
        batalhaOponente jogador oponente

menuAtaque :: Jogador -> Jogador -> IO Jogador
menuAtaque jogador oponente = do
    printMenuAtaque jogador
    indexCartaJogador <- getLine
    let cartaJogador = (cartasCampo jogador) !! ((read indexCartaJogador) -1)
    if atacou cartaJogador then erroCartaAtacou jogador oponente
    else if iD cartaJogador == 00 then erroCartaVazia jogador oponente
    else do
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
        let cartaDraw = draw (deck oponente)
        let oponente1 = Jogador (nomeJogador oponente) (colecao oponente) (drop 1 (deck oponente)) (vida oponente) (cartaDraw : removeCarta (iD cartaVazia) (mao oponente)) (cartasCampo oponente) (derrotados oponente)
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
    let diferenca = calculaDiferenca (ataque cartaAtacante) (ataque cartaAtacada)
    if modoAtaque cartaAtacada then Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) - diferenca) (mao jogador) (addCartaVazia (removeCarta (iD cartaAtacada) (cartasCampo jogador))) (derrotados jogador)
    else
        Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (addCartaVazia (removeCarta (iD cartaAtacada) (cartasCampo jogador))) (derrotados jogador)



logicaInvoc :: Jogador -> Carta
logicaInvoc oponente = do
    let ataqueForte = ataqueMaisForte (mao oponente)
    let cartaAtaque = achaAtaqueMaisForte (mao oponente) ataqueForte
    cartaAtaque

batalhaCartas :: Jogador -> Jogador -> Carta -> Carta -> IO Jogador
batalhaCartas jogador oponente cartaAtacante cartaAtacada = do
    if isCampoVazio (cartasCampo oponente) then do
        if atacou cartaAtacante then erroCartaAtacou jogador oponente
        else do
            let oponenteDireto = Jogador (nomeJogador oponente) (colecao oponente) (deck oponente) (vida oponente - (ataque cartaAtacante)) (mao oponente) (cartasCampo oponente) (derrotados oponente)
            let cartaAtacou = alteraStatusAtacouTrue cartaAtacante
            let jogadorAtacou = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (cartaAtacou : (removeCarta (iD cartaAtacou) (cartasCampo jogador))) (derrotados jogador)
            printCampo (vida jogadorAtacou) (vida oponenteDireto) (cartasCampo oponenteDireto) (cartasCampo jogadorAtacou) (mao jogadorAtacou)
            testaVitoria jogadorAtacou oponenteDireto
    else if (iD cartaAtacada) == 00 then erroCartaVazia jogador oponente
    else if atacou cartaAtacante then erroCartaAtacou jogador oponente
    else 
        batalhaCartasAtaque jogador oponente cartaAtacante cartaAtacada
    

erroCartaVazia :: Jogador -> Jogador -> IO Jogador
erroCartaVazia jogador oponente = do
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    putStrLn "\nVoce nao escolheu uma carta... escolha novamente\n"
    menuBatalha jogador oponente
 
isCampoVazio :: [Carta] -> Bool
isCampoVazio [] = True
isCampoVazio (x:xs)
    | (iD x) == iD cartaVazia = isCampoVazio xs
    | otherwise = False

erroCartaAtacou :: Jogador -> Jogador -> IO Jogador
erroCartaAtacou jogador oponente = do
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    putStrLn  "\nA carta que voce escolheu ja atacou... se ja atacou com todas termine seu turno\n"
    menuBatalha jogador oponente

batalhaCartasAtaque :: Jogador -> Jogador -> Carta -> Carta -> IO Jogador
batalhaCartasAtaque jogador oponente cartaAtacante cartaAtacada = do
    let diferenca = calculaDiferenca (ataque cartaAtacante) (ataque cartaAtacada)
    let cartaAtacou = alteraStatusAtacouTrue cartaAtacante
    let jogadorAtacou = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (cartaAtacou : (removeCarta (iD cartaAtacou) (cartasCampo jogador))) (derrotados jogador)
    if diferenca < 0 then jogadorPerdeAtaque jogadorAtacou oponente cartaAtacou diferenca
    else if diferenca > 0 then jogadorGanhaAtaque jogadorAtacou oponente cartaAtacada diferenca
    else empateAtq jogadorAtacou oponente cartaAtacou cartaAtacada

alteraStatusAtacouTrue :: Carta -> Carta
alteraStatusAtacouTrue carta = Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) (modoAtaque carta) True

alteraStatusAtacouFalse :: Carta -> Carta
alteraStatusAtacouFalse carta = Carta (iD carta) (nomeCarta carta) (ataque carta) (defesa carta) (modoAtaque carta) False

resetaAtacou :: [Carta] -> [Carta]
resetaAtacou [] = []
resetaAtacou (x:xs) = (alteraStatusAtacouFalse x) : (resetaAtacou xs)

empateDef :: Jogador -> Jogador -> IO Jogador
empateDef jogador oponente = do
    printCampo (vida jogador) (vida oponente) (cartasCampo oponente) (cartasCampo jogador) (mao jogador)
    putStr "\nAs cartas tem o mesmo nivel de forca e empataram, nenhuma foi destruida\n"
    menuBatalha jogador oponente

empateAtq :: Jogador -> Jogador -> Carta -> Carta -> IO Jogador
empateAtq jogador oponente cartaAtacante cartaAtacada = do
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (addCartaVazia (removeCarta (iD cartaAtacante) (cartasCampo jogador))) (derrotados jogador)
    let oponenteBatalha = Jogador (nomeJogador oponente) (colecao oponente) (deck oponente) (vida oponente) (mao oponente) (addCartaVazia (removeCarta (iD cartaAtacada) (cartasCampo oponente))) (derrotados oponente)
    printCampo (vida jogadorBatalha) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    putStr "\nAs cartas tem o mesmo nivel de forca e empataram, as duas foram destruidas\n"
    menuBatalha jogadorBatalha oponenteBatalha
 
jogadorPerdeAtaque :: Jogador -> Jogador -> Carta -> Int -> IO Jogador
jogadorPerdeAtaque jogador oponente carta diferenca = do
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) + diferenca) (mao jogador) (cartaVazia : (removeCarta (iD carta) (cartasCampo jogador))) (derrotados jogador)
    printCampo (vida jogadorBatalha) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    putStr "\nSua carta perdeu a batalha. Sua carta foi destruida e sua vida diminuiu ;-;\n"
    testaVitoria jogadorBatalha oponente

jogadorGanhaAtaque :: Jogador -> Jogador -> Carta -> Int -> IO Jogador
jogadorGanhaAtaque jogador oponente carta diferenca = do
    let oponenteBatalha = Jogador (nomeJogador oponente) (colecao oponente) (deck oponente) ((vida oponente) - diferenca) (mao oponente) (cartaVazia : (removeCarta (iD carta) (cartasCampo oponente))) (derrotados oponente)
    printCampo (vida jogador) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogador) (mao jogador)
    putStr "\nSua carta ganhou a batalha . A carta do oponente foi destruida e a vida dele diminuiu :D\n"
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
    putStr "\nSua carta perdeu a batalha. Sua vida diminuiu ;-;\n"
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) - diferenca) (mao jogador) (cartasCampo jogador) (derrotados jogador)
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
    putStrLn ""
    putStrLn "\n #-----------Menu de Invocacao-----------#"
    putStrLn ""
    putStrLn "\n #-----------Estas sao as cartas da sua mao-----------#\n"
    putStrLn ""
    putStrLn ("[1] -> " ++ repCarta ((mao jogador)!! 0 ))
    putStrLn ("[2] -> " ++ repCarta ((mao jogador)!! 1 ))
    putStrLn ("[3] -> " ++ repCarta ((mao jogador)!! 2 ))
    putStrLn ("[4] -> " ++ repCarta ((mao jogador)!! 3 ))
    putStrLn ("[5] -> " ++ repCarta ((mao jogador)!! 4 ))
    putStrLn ""
    putStrLn "\nDigite sua escolha: "

printMenuModo :: IO()
printMenuModo = do
    putStrLn "\n #-----------Menu de Modo-----------#"
    putStrLn ""
    putStrLn "\n #-----------Qual o modo da carta?-----------#\n"
    putStrLn "[1] -> Ataque"
    putStrLn "[2] -> Defesa"
    putStrLn ""
    putStrLn "\nEscolha uma opcao: "

printMenuAtaqueOpcoes :: IO()
printMenuAtaqueOpcoes = do
    putStrLn "\n #---------------Menu de Ataque---------------#"
    putStrLn "\n #---------O que quer fazer?---------#\n"
    putStrLn "[1] -> Atacar"
    putStrLn "[2] -> Terminar Turno"
    putStrLn "\nEscolha uma opcao: "

printMenuAtaque :: Jogador -> IO()
printMenuAtaque jogador = do
    putStrLn "\n #----------------Menu de Ataque----------------#"
    putStrLn "\n #---------Estas sao as cartas do seu campo---------#\n"
    putStrLn ("[1] -> " ++ repCarta (cartasCampo jogador!! 0) ++ repAtacou (cartasCampo jogador!! 0))
    putStrLn ("[2] -> " ++ repCarta (cartasCampo jogador!! 1) ++ repAtacou (cartasCampo jogador!! 1))
    putStrLn ("[3] -> " ++ repCarta (cartasCampo jogador!! 2) ++ repAtacou (cartasCampo jogador!! 2))
    putStrLn ("[4] -> " ++ repCarta (cartasCampo jogador!! 3) ++ repAtacou (cartasCampo jogador!! 3))
    putStrLn ("[5] -> " ++ repCarta (cartasCampo jogador!! 4) ++ repAtacou (cartasCampo jogador!! 4))
    putStrLn "\n"
    putStrLn "\nEscolha uma carta: "

repAtacou :: Carta -> String
repAtacou carta 
        | iD carta == 00 = ""
        | atacou carta && iD carta > 00 = "          Ja atacou" 
        | otherwise = "          Nao atacou"

printMenuAtaqueOponente :: Jogador -> IO()
printMenuAtaqueOponente oponente = do
    putStrLn "\n #----------------Menu de Ataque----------------#"
    putStrLn "\n #---------Estas sao as cartas do campo do oponente---------#"
    putStrLn ("[1] -> " ++ repCarta (cartasCampo oponente!! 0))
    putStrLn ("[2] -> " ++ repCarta (cartasCampo oponente!! 1))
    putStrLn ("[3] -> " ++ repCarta (cartasCampo oponente!! 2))
    putStrLn ("[4] -> " ++ repCarta (cartasCampo oponente!! 3))
    putStrLn ("[5] -> " ++ repCarta (cartasCampo oponente!! 4))
    putStrLn "\nEscolha uma carta para atacar, se nao houver cartas ataque diretamente: "



printLoose :: Jogador -> IO Jogador
printLoose jogador = do
    putStrLn "\n-----------You Loose------------\n"
    putStrLn "\n-----------Sua vida chegou a 0 ou suas cartas acabaram------------\n"
    mainMenu jogador

printWin :: Jogador -> Jogador -> IO Jogador
printWin jogador oponente = do
    putStrLn "\n------------------You Win-------------\n"
    putStrLn ("\n------------------Voce derrotou o "++ nomeJogador oponente ++ " -------------\n")
    let card = verificaOponente oponente
    putStrLn ("\n------------Voce ganhou as cartas " ++ repCarta (card !! 0) ++ " -------------\n")
    putStrLn ("\n------------Voce ganhou as cartas " ++ repCarta (card !! 1) ++ " -------------\n")
    putStrLn ("\n------------Voce ganhou as cartas " ++ repCarta (card !! 2) ++ " -------------\n")
    let jogadorWin = addDrop card jogador oponente
    mainMenu (Jogador (nomeJogador jogadorWin) (colecao jogadorWin) (geraDeckEmbaralhado (take 20 (reverse (deck jogadorWin)))) (vida jogadorWin) (mao jogadorWin) (cartasCampo jogadorWin) (oponente : derrotados jogadorWin))

printLinhaCartas :: [Carta] -> String
printLinhaCartas [] = ""
printLinhaCartas (x:xs)
    | iD x == 00 = "|  "++ "xxx" ++ "  |" ++ printLinhaCartas xs
    | iD x < 10 = "|   "++ show(iD x) ++ "   |" ++ printLinhaCartas xs
    | iD x < 100 = "|  "++ show(iD x) ++ "   |" ++ printLinhaCartas xs
    | otherwise = "|  "++ show(iD x) ++ "  |" ++ printLinhaCartas xs

printCampo :: Int -> Int -> [Carta] -> [Carta] -> [Carta] -> IO()
printCampo vidaJogador vidaOponente cartasOponente cartasJogador mao = do
    putStrLn ("\nVida Jogador = " ++ show vidaJogador ++ "\nVida Oponente = " ++ show vidaOponente)
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
    |iD x > 0 = "|id: " ++ (show(iD x)) ++ " | nome: " ++ (nomeCarta x) ++ " | ataque = " ++ (show (ataque x)) ++ "|"
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
addCartaDeck idCarta jog = Jogador (nomeJogador jog) (removeCarta idCarta (colecao jog)) (addCarta idCarta (colecao jog) (deck jog)) 8000 [] [] []

removeCarta :: Int -> [Carta] -> [Carta]
removeCarta idCarta [] = []
removeCarta idCarta (x:xs)
 |idCarta == iD x = xs
 |otherwise = x:removeCarta idCarta xs

removeCartaDeck :: Jogador -> IO Jogador
removeCartaDeck jog = do
 putStrLn "Id da carta: "
 idCarta <- getLine
 let j = Jogador (nomeJogador jog) (addCarta (read idCarta) (deck jog) (colecao jog)) (removeCarta (read idCarta) (deck jog)) 8000 [] [] []
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
 |iD carta == 0 = do 
     return jogador
 |isCampoVazio (cartasCampo jogador) = do 
    let jogadorAtualizado = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) - (ataque carta)) (mao jogador) (cartasCampo jogador) (derrotados jogador)
    printCampo (vida jogadorAtualizado) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorAtualizado) (mao jogadorAtualizado)
    return jogadorAtualizado
 |verificaMenorA carta (cartasCampo jogador) = do 
    let jogadorAtualizado2 = destroiCartaJogador jogador carta (pegaMenorA carta (cartasCampo jogador))
    printCampo (vida jogadorAtualizado2) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorAtualizado2) (mao jogadorAtualizado2)
    return jogadorAtualizado2
 |otherwise = return jogador


verificaMenorA :: Carta -> [Carta]-> Bool
verificaMenorA carta [] = False
verificaMenorA carta (x:xs)
 |(modoAtaque x) && ((ataque carta) > ataque x) && (not (iD x == 00)) = True
 |otherwise = verificaMenorA carta xs

pegaMenorA :: Carta -> [Carta] -> Carta
pegaMenorA carta (x:xs)
 |(modoAtaque x) && ((ataque carta) > ataque x) && (not (iD x == 001)) = x
 |otherwise = pegaMenorA carta xs

geraDeckEmbaralhado :: [Carta] -> [Carta]
geraDeckEmbaralhado [] = []
geraDeckEmbaralhado cartas = carta:geraDeckEmbaralhado (removeCarta (iD carta) cartas)
    where carta = (cartaAleatoria cartas)

cartaAleatoria :: [Carta] -> Carta
cartaAleatoria lista = (lista !! unsafePerformIO(randomRIO (0, (length lista) - 1)))

-- drops


verificaOponente :: Jogador -> [Carta]
verificaOponente op
  |nomeJogador op == "Primeiro periodo" = take 3 (drop 3 drops1)
  |nomeJogador op == "Segundo periodo" = take 3 (drop 3 drops2)
  |nomeJogador op == "Terceiro periodo" = take 3 (drop 3 drops3)
  |nomeJogador op == "Quarto periodo" = take 3 (drop 3 drops4)
  |nomeJogador op == "Quinto periodo" = take 3 (drop 3 drops5)
  |nomeJogador op == "Sexto periodo" = take 3 (drop 3 drops6)
  |nomeJogador op == "Setimo periodo" = take 3 (drop 3 drops7)
  |nomeJogador op == "Oitavo periodo" = take 3 (drop 3 drops8)
  |otherwise = take 3 (drop 3 drops9)

addDrop:: [Carta] -> Jogador -> Jogador -> Jogador 
addDrop card jog opon = Jogador (nomeJogador jog) (card ++ (colecao jog)) (deck jog) 8000 [] [] (derrotados jog)

-- 90% 10%
-- 1,2 e 3,4

drops1 :: [Carta]
drops1 = geraDeckEmbaralhado (concat (replicate 10000 [sePerdeu, python, fmcc1,fmcc2,calculo1, matematicaBasica, empolgacao, fome, 
  perdeuOnibus,esquecimento, repProgramacao1, programacao2, repProgramacao2,
  monitorProgramacao1, monitorProgramacao2, fe, uniao, conselhoEstudantil, livia,
  galdencioAmansado, joseFernando, eanesBenevolente, robertKalley, zeFuinha, calculo2, haskell, sono]))

-- 70% 30%
-- 1,2 e 3,4
drops2 :: [Carta]
drops2 = geraDeckEmbaralhado (concat (replicate 10000 [sePerdeu, python, fmcc1,fmcc2,calculo1, matematicaBasica, empolgacao, fome, 
  perdeuOnibus,esquecimento, repProgramacao1, programacao2, repProgramacao2,
  monitorProgramacao1, monitorProgramacao2, fe, uniao, conselhoEstudantil, livia,
  galdencioAmansado, joseFernando, eanesBenevolente, robertKalley, zeFuinha, 
  calculo2, haskell, sono, colaErrada, grafos, linear, eda, repEDA, leda, repLEDA, leda]))

-- 90% 10%
-- 3,4 e 5,6
drops3 :: [Carta]
drops3 = geraDeckEmbaralhado (concat (replicate 10000 [calculo2, haskell, sono, colaErrada, grafos, linear, eda, repEDA, repLEDA, leda,
 bd1, preguica, roubo, namoro, sagui, luizAntonio, adalberto, killer, 
 patriciaDuarte, nervosismo, campelo, areli, rohit, joseane, elmar, everton, 
 melina, fabioJorge, adalberto, crise, ead, prazo]))

-- 70% 30%
-- 3,4 e 5,6
drops4 :: [Carta]
drops4 = geraDeckEmbaralhado (concat (replicate 10000 [calculo2, haskell, sono, colaErrada, grafos, linear, eda, repEDA, repLEDA, leda,
 bd1, preguica, roubo, namoro, sagui, luizAntonio, adalberto, killer, 
 patriciaDuarte, nervosismo, campelo, areli, rohit, joseane, elmar, everton, 
 melina, fabioJorge, adalberto, crise, ead, prazo, crise, ead, prazo, optativasDo6, perdido, estatistica, engenhariaSoft, repEstatistica, repEngenhariaSoft,
 iA, pato, gato, cachorro]))


-- 90% 10%
-- 5,6 e 7,8
drops5 :: [Carta]
drops5 = geraDeckEmbaralhado (concat (replicate 10000 [crise, ead, prazo, optativasDo6, perdido, estatistica, engenhariaSoft, repEstatistica, repEngenhariaSoft,
 iA, pato, gato, cachorro, metodologiaCientifica, wifi, desmotivacao, 
 depressao, cachaca, ritalina, queridinho, resiliente, odio, ressaca, trabalhoGrupo, treta]))

-- 70% 30%
-- 5,6 e 7,8
drops6 :: [Carta]
drops6 = geraDeckEmbaralhado (concat (replicate 10000 [crise, ead, prazo, optativasDo6, perdido, estatistica, engenhariaSoft, repEstatistica, repEngenhariaSoft,
 iA, pato, gato, cachorro, metodologiaCientifica, wifi, desmotivacao, 
 depressao, cachaca, ritalina, queridinho, resiliente, odio, ressaca, trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1, estagio, 
 repCompiladores, sorte]))

-- 90% 10%
-- 7,8 e 9
drops7 :: [Carta]
drops7 = geraDeckEmbaralhado (concat (replicate 10000 [ressaca, trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1, estagio, 
 repCompiladores, sorte, amizade, vicio, iguana, dorDeCabeca, cheirado, 
 louco, brasileiro, resistente, mutante, gaudencioPossesso, colacao, tcc] ))

-- 70% 30%
-- 7,8 e 9
drops8 :: [Carta]
drops8 = geraDeckEmbaralhado (concat (replicate 10000 [ressaca, trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1, estagio, 
 repCompiladores, sorte, amizade, vicio, iguana, dorDeCabeca, cheirado, 
 louco, brasileiro, resistente, mutante, gaudencioPossesso, colacao, tcc,
  colacao, tcc, formaturaCara, projetoEmComputacao2, emprego, laguinho, greve]))

-- 60% 40%
-- 9
drops9 :: [Carta]
drops9 = geraDeckEmbaralhado [colacao, formaturaCara, tcc, projetoEmComputacao2, emprego, laguinho, greve,
 fimDoMundo, insonia, jacare, procurandoEmprego, poliglota, genioMaster, falheiEmTudo, ressaca,
  trabalhoGrupo, treta, pcQuebrado, provas3, compiladores, projetoEmComputacao1]


-- Inimigos


periodo1 :: Jogador
periodo1 = Jogador "Primeiro periodo" [] (geraDeckEmbaralhado (concat (replicate 10000 [matematicaBasica, matematicaBasica  , python, fe, repProgramacao1,
 repProgramacao1, eanesBenevolente, robertKalley, matematicaBasica, perdeuOnibus, python, fe,
  repProgramacao1, robertKalley, eanesBenevolente, robertKalley, perdeuOnibus, python,
   perdeuOnibus,fe]))) 8000 [] [] []

periodo2 :: Jogador
periodo2 = Jogador "Segundo periodo" [] (geraDeckEmbaralhado (concat (replicate 10000 [sePerdeu, empolgacao, fome, esquecimento, zeFuinha,
 joseFernando, galdencioAmansado, conselhoEstudantil, uniao, monitorProgramacao2,
  monitorProgramacao1, repProgramacao2, programacao2,calculo1,fmcc2, fmcc1,
   esquecimento, fome, sePerdeu, empolgacao])))
 8000 [] [] []

periodo3 :: Jogador
periodo3 = Jogador "Terceiro periodo" [] (geraDeckEmbaralhado (concat (replicate 10000 [sono, colaErrada, grafos, eda, repEDA, leda, repLEDA, bd1,
 roubo, luizAntonio, patriciaDuarte,areli, joseane, everton, melina, fabioJorge,colaErrada, 
 bd1, sono, repEDA]))) 8000 [] [] []

periodo4 :: Jogador
periodo4 = Jogador "Quarto periodo" [] (geraDeckEmbaralhado (concat (replicate 10000 [substituto, elmar, rohit, campelo, nervosismo, killer,
 adalberto, sagui, namoro, preguica, linear, haskell, calculo2, substituto, elmar, rohit,
  campelo, nervosismo, killer, adalberto]))) 8000 [] [] []

periodo5 :: Jogador
periodo5 = Jogador "Quinto periodo" [] (geraDeckEmbaralhado (concat (replicate 10000 [crise, prazo, optativasDo6, estatistica, engenhariaSoft,
 repEstatistica, repEngenhariaSoft, iA, pato, cachorro, metodologiaCientifica, wifi, 
 desmotivacao, cachaca, crise, prazo, optativasDo6, estatistica, engenhariaSoft, 
 repEstatistica]))) 8000 [] [] []

periodo6 :: Jogador
periodo6 = Jogador "Sexto periodo" [] (geraDeckEmbaralhado (concat (replicate 10000 [odio, resiliente, queridinho, ritalina, depressao,gato,
 perdido, ead, prazo, metodologiaCientifica, odio, resiliente, queridinho, ritalina,
  depressao,gato, perdido, ead, prazo, metodologiaCientifica]))) 8000 [] [] []

periodo7 :: Jogador
periodo7 = Jogador "Setimo periodo" [] (geraDeckEmbaralhado (concat (replicate 10000 [ressaca, trabalhoGrupo, treta, compiladores,
 repCompiladores, sorte, iguana, dorDeCabeca, mutante, ressaca, trabalhoGrupo, treta,
  compiladores, repCompiladores, sorte, iguana, dorDeCabeca, mutante,ressaca,
   trabalhoGrupo ]))) 8000 [] [] []

periodo8 :: Jogador
periodo8 = Jogador "Oitavo periodo" [] (geraDeckEmbaralhado (concat (replicate 10000 [pcQuebrado, projetoEmComputacao1, estagio, provas3,
 amizade, vicio, cheirado, louco, brasileiro, resistente, gaudencioPossesso,pcQuebrado,
 projetoEmComputacao1, estagio, provas3, amizade, vicio, cheirado, louco, brasileiro,
 resistente]))) 8000 [] [] []

periodo9 :: Jogador
periodo9 = Jogador "Nono periodo" [] (geraDeckEmbaralhado (concat (replicate 10000 [colacao, formaturaCara, tcc, projetoEmComputacao2, emprego,
 laguinho, greve, fimDoMundo, insonia, jacare, procurandoEmprego, poliglota, genioMaster,
  falheiEmTudo, colacao, formaturaCara, tcc, projetoEmComputacao2, emprego, laguinho])))  8000 [] [] []