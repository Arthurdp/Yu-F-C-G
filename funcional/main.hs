module Main where
import Batalha
import Deck
import Menu
import Inimigos

escolher :: Int -> Jogador -> IO Jogador
escolher n jog
 |n == 1 = batalha jog periodo1
 |n == 2 = gerenciaDeck jog
 |n == 3 = putStrLn "ok né... xau"


mainMenu :: Jogador -> IO()
mainMenu jog = do
 menu
 opcao <- getLine
 escolher (read opcao) jog


main :: IO()
main = do
 let nome = printLogo
 let jog = Jogador nome [] [] 8000 [] [] []
 

