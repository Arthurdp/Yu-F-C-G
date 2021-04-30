module Menu where

printLogo :: IO String
printLogo = do
    putStrLn "  Y88b   d88P                   8888888888         d8888b              d8888b"
    putStrLn "   Y88b d88P                    888               d88P  Y88b         d88P  Y88b"
    putStrLn "    Y88o88P                     888               888    888         888    888"
    putStrLn "     Y888P     888   888        8888888           888                888"
    putStrLn "      888      888   888        888               888                888  88888"
    putStrLn "      888      888   888 888888 888     888888    888    888  888888 888    888"
    putStrLn "      888      Y88b  888        888               Y88b  d88P         Y88b  d88P"
    putStrLn "      888       'Y88888         888                'Y8888P'           'Y8888P88'"
    menuNome


menuNome :: IO String
menuNome = do
    putStrLn "\n\n "
    putStrLn "\n\nNome do jogador: "
    a <- getLine
    putStrLn "\n\n "
    print( "Bem vindo " ++ a)
    return a


menu :: IO()
menu = do
    putStrLn "\n\n "
    putStrLn "\n #   Menu   #\n"
    putStrLn "\n\n "
    putStrLn "[1] -> Iniciar jogo"
    putStrLn "[2] -> Deck"
    putStrLn "[3] -> Sair"
    putStrLn "\n\n "
    putStrLn "\n\nDigite sua escolha: "

menuColecao :: IO()
menuColecao  =  do
                putStrLn "\n          #   coleção  #\n\n\n"
                putStrLn "[1] -> Adicionar cartas ao deck"
                putStrLn "[2] -> Sair"

menuDeck :: IO()
menuDeck  =  do
                putStrLn "\n          #   Deck   #\n\n\n"
                putStrLn "[1] -> Coleção"
                putStrLn "[2] -> Remover cartas do deck"
                putStrLn "[3] -> Sair"


menuIniciar :: IO()
menuIniciar =  do
                putStrLn "\n              #   Modo de jogo   #\n\n\n"
                putStrLn "[1] -> Campanha"
                putStrLn "[2] -> Duelo livre"
                putStrLn "[3] -> Sair"
                putStr "\n\nDigite sua opção: "








