module Main where

import GHC.IO.Encoding
import System.IO.Unsafe
import System.Random (randomRIO)
import Menu
import Jogador
import Inimigos
import Cartas


main :: IO()
main = do
 let nome = printLogo
 let jog = Jogador nome [] [] 8000 [] [] []
 mainMenu jog

escolher :: Int -> Jogador -> IO Jogador
escolher n jog
 |n == 1 = batalha jog periodo1
 |n == 2 = gerenciaDeck jog
 |n == 3 = putStrLn "ok né... xau"

mainMenu :: Jogador -> IO Jogador
mainMenu jog = do
 menu
 opcao <- getLine
 escolher (read opcao) jog

--- batalha 

draw :: [Carta] -> [Carta]
draw deck = take 1 (reverse deck)

geraMao :: [Carta] -> [Carta]
geraMao deck = take 5 (reverse deck)

geraMao4 :: [Carta] -> [Carta]
geraMao4 deck = take 4 (reverse deck)

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
    let oponente2 = (nomeJogador oponente1) (colecao oponente1) (deck oponente1) (vida oponente1) (addCartaVazia (removeCarta (iD cartaInvoc) mao oponente1)) (cartasCampo oponente1) (derrotados oponente1)
    printCampo (vida jogadorAtacou) (vida oponente2) (cartasCampo oponente2) (cartasCampo jogadorAtacou) (mao jogadorAtacou)
    let oponenteAtacou = ataqueOponente jogadorAtacou oponente2
    let oponenteAtacou2 = (nomeJogador oponenteAtacou) (colecao oponenteAtacou) (deck oponenteAtacou) (vida oponenteAtacou) (mao oponenteAtacou) (resetaAtacou (cartasCampo oponenteAtacou)) (derrotados oponenteAtacou)
    batalhaRecursiva jogador oponenteAtacou2

ataqueOponente :: Jogador -> Jogador -> IO Jogador
ataqueOponente jogador oponente = do
    let cartaDerrotada = logicaAtaque
    let cartaAtacante = achaAtaqueMaisForte (cartasCampo oponente) (ataqueMaisForte (cartasCampo oponente))
    let cartaAtacou = alteraStatusAtacouTrue cartaAtacante
    let oponenteAtacou = (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (cartaAtacou ++ (removeCarta (iD cartaAtacou) cartasCampo jogador)) (derrotados jogador)

    if (iD cartaDerrotada) == 00 then oponenteAtacou
    else ataqueOponente jogador oponenteAtacou

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
erroCartaAtacou jogador oponente = do
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
    let jogadorAtacou = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) (vida jogador) (mao jogador) (cartaAtacou ++ (removeCarta (iD cartaAtacou) cartasCampo jogador)) (derrotados jogador)
    if diferenca < 0 then jogadorPerdeDefesa jogadorAtacou oponente diferenca
    else if diferenca > 0 then jogadorGanhaDefesa jogadorAtacou oponente cartaAtacada diferenca
    else empate jogadorAtacou oponente

jogadorPerdeDefesa :: Jogador -> Jogador -> Int -> IO Jogador
jogadorPerdeDefesa jogador oponente  diferenca = do
    putStr "Sua carta perdeu a batalha. Sua vida diminuiu ;-;"
    let jogadorBatalha = Jogador (nomeJogador jogador) (colecao jogador) (deck jogador) ((vida jogador) + diferenca) (mao jogador) (cartasCampo jogador) (derrotados jogador)
    printCampo (vida jogadorBatalha) (vida oponente) (cartasCampo oponente) (cartasCampo jogadorBatalha) (mao jogadorBatalha)
    testaVitoria jogadorBatalha oponente

jogadorGanhaDefesa :: Jogador -> Jogador -> Carta -> IO Jogador
jogadorGanhaDefesa jogador oponente carta = do
    putStr "Sua carta ganhou a batalha . A vida do oponente diminuiu :D"
    let oponenteBatalha = Jogador (nomeJogador oponente) (colecao oponente) (deck oponente) (vida oponente) (mao oponente) (addCartaVazia (removeCarta (iD carta) (cartasCampo oponente))) (derrotados oponente)
    printCampo (vida jogador) (vida oponenteBatalha) (cartasCampo oponenteBatalha) (cartasCampo jogador) (mao jogador)
    testaVitoria jogador oponenteBatalha

calculaDiferenca :: Int -> Int -> Int
calculaDiferenca cartaAtacante cartaAtacada = cartaAtacante - cartaAtacada

testaVitoria :: Jogador -> Jogador -> IO Jogador
testaVitoria jogador oponente = do
    if (vida jogador) == 0 then (printLoose jogador)
    else if (vida oponente) == 0 then (printWin jogador)
    else 
        menuAtaque jogador oponente

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
    putStrLn "\n #-----------Menu de Invocação-----------#\n"
    putStrLn "\n\n"
    putStrLn "\n #-----------Estas são as cartas da sua mão-----------#\n"
    putStrLn "\n"
    putStrLn ("\n[1] -> " ++ repCarta ((mao jogador)!! 0 ))
    putStrLn ("\n[2] -> " ++ repCarta ((mao jogador)!! 1 ))
    putStrLn ("\n[3] -> " ++ repCarta ((mao jogador)!! 2 ))
    putStrLn ("\n[4] -> " ++ repCarta ((mao jogador)!! 3 ))
    putStrLn ("\n[5] -> " ++ repCarta ((mao jogador)!! 4 ))
    putStrLn "\n\n"
    putStrLn "\n\nDigite sua escolha: "


printMenuAtaque :: Jogador -> IO() 
printMenuAtaque jogador = do
    putStrLn "\n\n"
    putStrLn "\n #-----------Menu de Ataque-----------#\n"
    putStrLn "\n\n"
    putStrLn "\n #-----------Estas são as cartas do seu campo-----------#\n"
    putStrLn "\n"
    putStrLn ("\n[1] -> " ++ repCarta ((cartasCampo jogador)!! 0 ))
    putStrLn ("\n[2] -> " ++ repCarta ((cartasCampo jogador)!! 1 ))
    putStrLn ("\n[3] -> " ++ repCarta ((cartasCampo jogador)!! 2 ))
    putStrLn ("\n[4] -> " ++ repCarta ((cartasCampo jogador)!! 3 ))
    putStrLn ("\n[5] -> " ++ repCarta ((cartasCampo jogador)!! 4 ))
    putStrLn "\n\n"
    putStrLn "\n [6] -> Terminar turno"
    putStrLn "\n\nEscolha uma carta: "

printMenuAtaqueOponente :: Jogador -> IO()
printMenuAtaqueOponente oponente = do
    putStrLn "\n\n"
    putStrLn "\n #-----------Menu de Ataque-----------#\n"
    putStrLn "\n\n"
    putStrLn "\n #-----------Estas são as cartas do campo do oponente-----------#\n"
    putStrLn "\n"
    putStrLn ("\n[1] -> " ++ (repCarta ((cartasCampo oponente) !! 0 ))) 
    putStrLn ("\n[2] -> " ++ (repCarta ((cartasCampo oponente) !! 1 ))) 
    putStrLn ("\n[3] -> " ++ (repCarta ((cartasCampo oponente) !! 2 ))) 
    putStrLn ("\n[4] -> " ++ (repCarta ((cartasCampo oponente) !! 3 ))) 
    putStrLn ("\n[5] -> " ++ (repCarta ((cartasCampo oponente) !! 4 ))) 
    putStrLn "\n\n"
    putStrLn "\\n\nEscolha uma carta para atacar, se não houver cartas ataque diretamente: "



printLoose :: Jogador -> IO Jogador
printLoose jogador = do
    putStrLn "\n-----------You Loose------------\n"
    mainMenu jogador

printWin :: Jogador -> IO Jogador
printWin jogador = do
    putStrLn "\n------------You Win-------------\n"
   -- let jogadorWin = -- add drops Will
    mainMenu jogador

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
\\n-------------------Sua Mão-------------------\
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
repCarta x = "|id: " ++ (show(iD x)) ++ " | nome: " ++ (nomeCarta x) ++ " | ataque = " ++ (show (ataque x)) ++ " | defesa = " ++ (show (defesa x)) ++ "|"

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
  putStrLn "Você não possui esta carta."
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
  putStrLn "opção inválida"
  vizualizaColecao jog

vizualizaColecao :: Jogador -> IO Jogador
vizualizaColecao jog = do
 menuColecao
 putStrLn "Coleção:"
 putStrLn (repLista (colecao jog))
 putStrLn "(1)Adicionar carta ao Deck \n(2)Deck"
 opcao <- getLine
 vizualizaColecaoOp opcao jog
 
vizualizaDeck :: Jogador -> IO()
vizualizaDeck jog = do 
 putStrLn "Esse é seu deck:"
 putStrLn (repLista (deck jog))

verificaVolta :: Jogador -> IO Jogador
verificaVolta jog
 |length(deck jog) < 20 = do
  putStrLn "deck incompleto, tenha 20 cartas no deck para voltar."
  gerenciaDeck jog
 |otherwise = gerenciaDeck jog
 
gerenciaDeckOp :: String -> Jogador -> IO Jogador
gerenciaDeckOp op jog
 |op == "1" = vizualizaColecao jog
 |op == "2" = removeCartaDeck jog
 |op == "3" = verificaVolta jog 
 |otherwise = do 
  putStrLn "opção inválida"
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

logicaAtaque :: [Carta] -> [Carta] -> Carta
logicaAtaque x y
 |(ataque cartaAtaque) > defesa maiorDefesaDef = maiorDefesaDef
 |(ataque cartaAtaque) > ataque maiorAtaqueAta = maiorAtaqueAta
 |verificaMenorD cartaAtaque (pegaModoDefesa x) = pegaMenorD cartaAtaque (pegaModoDefesa x)
 |verificaMenorA cartaAtaque (pegaModoAtaque x) = pegaMenorA cartaAtaque (pegaModoAtaque x)
 |otherwise = menorDefesaDef
 where cartaAtaque = (ataqueMaisFortee (pegaModoAtaque y))
       maiorDefesaDef = (defesaMaisFortee (pegaModoDefesa x))
       menorDefesaDef = (defesaMaisFraca (pegaModoDefesa x)) 
       maiorAtaqueAta = (ataqueMaisFortee (pegaModoAtaque x))

verificaMenorD :: Carta -> [Carta]-> Bool
verificaMenorD carta [] = False
verificaMenorD carta (x:xs)
 |(ataque carta) > defesa x = True
 |otherwise = verificaMenorD carta xs

pegaMenorD :: Carta -> [Carta] -> Carta
pegaMenorD carta (x:xs)
 |(ataque carta) > defesa x = x
 |otherwise = pegaMenorD carta xs

verificaMenorA :: Carta -> [Carta]-> Bool
verificaMenorA carta [] = False
verificaMenorA carta (x:xs)
 |(ataque carta) > ataque x = True
 |otherwise = verificaMenorA carta xs

pegaMenorA :: Carta -> [Carta] -> Carta
pegaMenorA carta (x:xs)
 |(ataque carta) > ataque x = x
 |otherwise = pegaMenorA carta xs

geraDeckEmbaralhado :: [Carta] -> [Carta]
geraDeckEmbaralhado [] = []
geraDeckEmbaralhado cartas = carta:geraDeckEmbaralhado (removeCarta (iD carta) cartas)  
    where carta = (cartaAleatoria cartas)

cartaAleatoria :: [Carta] -> Carta
cartaAleatoria lista = (lista !! unsafePerformIO(randomRIO (0, (length lista) - 1)))

-- 

