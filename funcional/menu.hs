
menuNome :: IO()
menuNome = do
    putStrLn "\n\n "
    putStrLn "\n\nNome do jogador: "
    a <- getLine
    putStrLn "\n\n "
    print( "\n\nNome do jogador: " ++ a)

printLogo :: IO()
printLogo = do
    putStrLn "  Y88b   d88P                   8888888888         d8888b              d8888b"
    putStrLn "   Y88b d88P                    888               d88P  Y88b         d88P  Y88b"
    putStrLn "    Y88o88P                     888               888    888         888    888"
    putStrLn "     Y888P     888   888        8888888           888                888"
    putStrLn "      888      888   888        888               888                888  88888"
    putStrLn "      888      888   888 888888 888     888888    888    888  888888 888    888"
    putStrLn "      888      Y88b  888        888               Y88b  d88P         Y88b  d88P"
    putStrLn "      888       'Y88888         888                'Y8888P'           'Y8888P88'"




menu :: jogador -> IO()
menu p =  do
                putStrLn "\n              #   Menu   #\n\n\n"
                putStrLn "[1] -> Iniciar jogo"
                putStrLn "[2] -> Deck"
                putStrLn "[3] -> Status do jogador"
                putStrLn "[4] -> Sair"
                putStr "\n\nDigite sua opção: "
                readLn :: IO()

menuDeck :: jogador -> IO()
menuDeck p =  do
                putStrLn "\n           #   Deck   #\n\n\n"
                putStrLn "[1] -> Coleção"
                putStrLn "[2] -> Remover cartas do deck"
                putStrLn "[3] -> Sair"
                putStr "\n\nDigite sua opção: "
                readLn :: IO()

menuColecao :: jogador -> IO()
menuColecao  p =  do
                putStrLn "\n           #   Deck   #\n\n\n"
                putStrLn "[1] -> Adicionar cartas ao deck"
                putStrLn "[2] -> Sair"


menuIniciar :: jogador -> IO()
menuIniciar p =  do
                putStrLn "\n              #   Modo de jogo   #\n\n\n"
                putStrLn "[1] -> Campanha"
                putStrLn "[2] -> Duelo livre"
                putStrLn "[3] -> Sair"
                putStr "\n\nDigite sua opção: "
                readLn :: IO()

menuCampanha:: jogador -> IO()
menuCampanha p = do


menuDuelo:: jogador -> IO()
menuDuelo p = do







