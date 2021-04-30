module Deck where
import Jogador
import Cartas
import Menu
import Inimigos

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



 