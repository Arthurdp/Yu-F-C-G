game:-
    call(main),
    halt.
    

main:-
    nl, write("  Y88b   d88P                   8888888888         d8888b              d8888b"),nl,
        write("   Y88b d88P                    888               d88P  Y88b         d88P  Y88b"), nl,
        write("    Y88o88P                     888               888    888         888    888"), nl,
        write("     Y888P     888   888        8888888           888                888"), nl,
        write("      888      888   888        888               888                888  88888"), nl,
        write("      888      888   888 888888 888     888888    888    888  888888 888    888"), nl,
        write("      888      Y88b  888        888               Y88b  d88P         Y88b  d88P"), nl,
        write("      888        Y88888         888                 Y8888P            Y8888P88"), nl,
        call(menuNome).
    
inGame:-
    call(menu),
    call(inGame).

menuNome:-
    nl, write("Digite seu nome: "),
    read(X),
    atom_concat("Bem vindo ", X, Y),
    write(Y), nl,
    call(inGame).

menu:-
    nl, write("#   Menu   #"),nl,
    write("[1] -> Campanha"), nl,
    write("[2] -> Duelo livre"), nl,
    write("[3] -> Deck"), nl,
    write("[4] -> Sair"), nl,nl,
    write("Digite sua escolha: "),nl,
    read(X).

menuColecao:-
    nl, write("#   colecao  #"),nl,
    nl, write("[1] -> Adicionar cartas ao deck"),
    nl, write("[2] -> Sair").

menuDeck:-
    nl, write("#   Deck   #"),nl,
    nl, write("[1] -> Colecao"),
    nl, write("[2] -> Remover cartas do deck"),
    nl, write("[3] -> Sair").

printMenuDuelo:-
    nl, write("#   escolha seu oponente  #"),nl,
    nl, write("[1] -> Primeiro periodo"),
    nl, write("[2] -> Segundo periodo"),
    nl, write("[3] -> Terceiro periodo"),
    nl, write("[4] -> Quarto periodo"),
    nl, write("[5] -> Quinto periodo"),
    nl, write("[6] -> Sexto periodo"),
    nl, write("[7] -> Setimo periodo"),
    nl, write("[8] -> Oitavo periodo"),
    nl, write("[9] -> Nono periodo"),
    nl, write("[10] -> Sair"), nl,
    nl, write("Digite sua opcao: ").
    