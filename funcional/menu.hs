module Menu where
import GHC.IO.Encoding

printLogo :: IO ()
printLogo = do
    putStrLn "\n  Y88b   d88P                   8888888888         d8888b              d8888b"
    putStrLn "   Y88b d88P                    888               d88P  Y88b         d88P  Y88b"
    putStrLn "    Y88o88P                     888               888    888         888    888"
    putStrLn "     Y888P     888   888        8888888           888                888"
    putStrLn "      888      888   888        888               888                888  88888"
    putStrLn "      888      888   888 888888 888     888888    888    888  888888 888    888"
    putStrLn "      888      Y88b  888        888               Y88b  d88P         Y88b  d88P"
    putStrLn "      888       'Y88888         888                'Y8888P'           'Y8888P88'"
    menuNome


menuNome :: IO()
menuNome = do
    putStrLn "\nDigite seu nome: "

menu :: IO()
menu = do
    setLocaleEncoding utf8
    putStrLn "\n #   Menu   #"
    putStrLn "\n "
    putStrLn "[1] -> Campanha"
    putStrLn "[2] -> Duelo livre"
    putStrLn "[3] -> Deck"
    putStrLn "[4] -> Sair"
    putStrLn ""
    putStrLn "\nDigite sua escolha: "

menuColecao :: IO()
menuColecao  =  do
    setLocaleEncoding utf8
    putStrLn "\n          #   colecao  #\n"
    putStrLn "[1] -> Adicionar cartas ao deck"
    putStrLn "[2] -> Sair"

menuDeck :: IO()
menuDeck  =  do
    setLocaleEncoding utf8
    putStrLn "\n          #   Deck   #\n"
    putStrLn "[1] -> Colecao"
    putStrLn "[2] -> Remover cartas do deck"
    putStrLn "[3] -> Sair"

printMenuDuelo :: IO()
printMenuDuelo = do
    setLocaleEncoding utf8
    putStrLn "\n          #   escolha seu oponente  #\n"
    putStrLn "[1] -> Primeiro periodo"
    putStrLn "[2] -> Segundo periodo"
    putStrLn "[3] -> Terceiro periodo"
    putStrLn "[4] -> Quarto periodo"
    putStrLn "[5] -> Quinto periodo"
    putStrLn "[6] -> Sexto periodo"
    putStrLn "[7] -> Setimo periodo"
    putStrLn "[8] -> Oitavo periodo"
    putStrLn "[8] -> Nono periodo"
    putStrLn "[10] -> Sair"
    putStrLn "\nDigite sua opcao: "





