module Menu where

printLogo :: IO ()
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


menuNome :: IO()
menuNome = do
    putStrLn "\n "
    putStrLn "\nDigite seu nome: "

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



printMenuDuelo :: IO()
printMenuDuelo = do
    putStrLn "\n          #   escolha seu oponente  #\n\n\n"
    putStrLn "[1] -> Primeiro período"
    putStrLn "[2] -> Segundo período"
    putStrLn "[3] -> Terceiro período"
    putStrLn "[4] -> Quarto período"
    putStrLn "[5] -> Quinto período"
    putStrLn "[6] -> Sexto período"
    putStrLn "[7] -> Setimo período"
    putStrLn "[8] -> Oitavo período"
    putStrLn "[8] -> Nono período"
    putStrLn "[10] -> Sair"
    putStrLn "\n\nDigite sua opção: "

menuDuelo :: Jogador -> IO()
menuDuelo jog  = do
    printMenuDuelo
    opcao <- getLine
    let x = read opcao
    escolheOp x jog
      

escolheOp:: String -> Jogador -> IO()
escolheOp x jog
  |x == "1" = batalha jog periodo1
      |x == "2" = batalha jog periodo2
      |x == "3" = batalha jog periodo3
      |x == "4" = batalha jog periodo4
      |x == "5" = batalha jog periodo5
      |x == "6" = batalha jog periodo6
      |x == "7" = batalha jog periodo7
      |x == "8" = batalha jog periodo8
      |x == "9" = batalha jog periodo9
      |otherwise  = mainMenu
        





