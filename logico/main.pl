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
nl, writeln("Digite seu nome: "),
read(X),
atom_concat("Bem vindo ", X, Y),nl,
write(Y), nl,
Jog = [X,[],[1, 2, 7, 11, 3, 12, 22, 23, 2, 5, 7, 11, 12, 23, 22, 23, 5, 7, 5, 11],8000,[],[],[],[]],
menu(Jog).

menu(Jog):-
    nl, write("#   Menu   #"),nl,
    write("[1] -> Campanha"), nl,
    write("[2] -> Duelo livre"), nl,
    write("[3] -> Deck"), nl,
    write("[4] -> Sair"), nl,nl,
    write("Digite sua escolha: "),nl,
    read(X),
    mainMenu(X,Jog).


mainMenu(1,Jog):- escolheInimigo(Jog, R),inimigo(R,DeckI,VidaI,MaoI,CampoI),
Ini = [R,DeckI,VidaI,MaoI,CampoI],nl,write('Batalha contra o '),write(R), write('º periodo'), 
 batalha(Jog,Ini, Jog1),menu(Jog1).
mainMenu(2,Jog):- menuDuelo(Jog).
mainMenu(3,Jog):- deck(Jog).
mainMenu(4,_):- write('É... xau'),nl, halt.



menuDuelo(Jog):- call(printMenuDuelo), read(X),X =:=10,menu(Jog);
    verificaDuelo(X,Jog),batalha(Jog,X, Jog1),menu(Jog1) .

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
nl, writeln("Digite sua opcao: ").


verificaDuelo(X,Jog):- Jog = [_,_,_,_,_,_,_,DerrJ], member(X,DerrJ); 
nl,write('Você não pode atacar esse oponete ainda, escolha outro.'),nl, menuDuelo(Jog).

escolheInimigo([_,_,_,_,_,_,_,[]], 1).
escolheInimigo([_,_,_,_,_,_,_,DerrJ], R):-
    max_list(DerrJ,I),I < 9, R is I + 1; R = 9.

draw5([A,B,C,D,E|T],Mao,Deck) :-
    Mao = [A,B,C,D,E],
    Deck = T.

draw4([A,B,C,D|T],Mao,Deck) :-
    Mao = [A,B,C,D],
    Deck = T.

draw([A|T],Mao,Mao1,Deck) :-
    trocaCarta(Mao,00,A,Mao1),
    Deck = T.


batalha([NomeJ,ColJ,DeckJ,VidaJ,_,_,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,_,_],JogR) :- 
    CampoJ1 = [00,00,00,00,00],
    CampoI1 = [00,00,00,00,00], 
    geraDeckEmbaralhado(DeckJ,DeckJEm),
    geraDeckEmbaralhado(DeckI,DeckIEm),
    draw5(DeckJEm,MaoJ1,DeckDrawJ),
    draw4(DeckIEm,MaoI1,DeckDrawI),
    printCampo(VidaJ,VidaI,CampoI1,CampoJ1,MaoJ1,DeckDrawJ),
    menuInvoc(MaoJ1),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,MaoJ1,Carta),
    trocaCarta(CampoJ1,00,Carta,CampoJ2),
    retiraCartaIndex(MaoJ1,Index,1,MaoJ2),
    
    batalhaInimigo([NomeJ,ColJ,DeckDrawJ,VidaJ,MaoJ2,CampoJ2,AtacouJ,DerrJ],[NomeI,DeckDrawI,VidaI,MaoI1,CampoI1], JogNew, IniNew),
    batalhaJogador(JogNew,IniNew,JogR1),
    JogR1 = [NomeFim,ColFim,_,_,_,_,_,DerrFim],
    JogR = [NomeFim,ColFim,DeckJ,8000,[],[],[],DerrFim].

batalhaJogador([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
    length(DeckJ,Len),
    Len =:= 0,
    printLoose0([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],JogR);
    draw(DeckJ,MaoJ,MaoJ1,DeckDrawJ),
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ1,DeckDrawJ),

    menuInvoc(MaoJ1),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,MaoJ1,Carta),

    meuIf(CampoJ,Carta,CampoJ1),
    retiraCartaIndex(MaoJ1,Index,1,MaoJ2),
    printCampo(VidaJ,VidaI,CampoI,CampoJ1,MaoJ2,DeckDrawJ),
    Jog = [NomeJ,ColJ,DeckDrawJ,VidaJ,MaoJ2,CampoJ1,AtacouJ,DerrJ],
    menuBatalha(Jog,[NomeI,DeckI,VidaI,MaoI,CampoI],JogR).

meuIf(CampoJ,Carta,CampoJ1) :-
    isCampoCheio(CampoJ),
    campoCheio(CampoJ,Carta,CampoJ1);
    trocaCarta(CampoJ,00,Carta,CampoJ1).

campoCheio(Campo,Carta,Campo1) :-
    menuCampoCheio(Campo),read(Index),
    Index1 is Index-1,
    trocaCartaIndex(Campo,Index1,0,Carta,Campo1).

isCampoCheio([]).
isCampoCheio([H|T]) :-
    H > 0, isCampoCheio(T).

menuBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
    printMenuAtaqueOpcoes(),
    read(Op),
    leOpcaoBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],Op,JogR).

leOpcaoBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],Op,JogR) :-
    Op =:= 1,
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ,DeckJ),
    menuAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR);
    batalhaInimigo([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogNew, IniNew),
    batalhaJogador(JogNew, IniNew,JogR).

menuAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
    printMenuAtaqueCampo(CampoJ,CampoI,AtacouJ),
    writeln('\nEscolha uma carta do seu campo: '),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,CampoJ,Carta),
    testaAtacou([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR,Carta,Index1).

testaAtacou([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR,Id,IndexJ) :-
    member(IndexJ, AtacouJ),
    erroCartaAtacou([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR)
    ; 
    Id =:= 00,
    erroCartaVazia([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR)
    ;
    writeln('Escolha uma carta do campo do inimigo: '),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,CampoI,CartaI),
    carta(Id,_,AtkAtacante), carta(CartaI,_,AtkAtacada),
    batalhaCartas([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,AtkAtacante,AtkAtacada,CartaI,IndexJ,Index1).

batalhaCartas([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,AtkAtacante,AtkAtacada,CartaI,IndexJ,IndexI) :- 
    isCampoVazio(CampoI),
    ataqueCampoVazio([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],
        [NomeI,DeckI,VidaI,MaoI,CampoI],JogR,AtkAtacante,IndexJ)
    ;
    CartaI =:= 00,
    erroCartaVazia([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR)
    ;
    AtkAtacante > AtkAtacada, 
    jogadorGanhaAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,AtkAtacante,AtkAtacada,IndexJ,IndexI)
    ;
    AtkAtacante < AtkAtacada,
    jogadorPerdeAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,AtkAtacante,AtkAtacada,IndexJ)
    ;
    empate([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,IndexJ,IndexI).

ataqueCampoVazio([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR,AtkAtacante,IndexJ) :-
    VidaI1 is VidaI - AtkAtacante,
    printCampo(VidaJ,VidaI1,CampoI,CampoJ,MaoJ,DeckJ),
    add(AtacouJ,IndexJ,AtacouJ1),
    write('\nVoce atacou o inimigo diretamente e retirou -'), write(AtkAtacante), writeln(' da vida dele!'),
    testaVitoria([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ1,DerrJ],[NomeI,DeckI,VidaI1,MaoI,CampoI],JogR).

jogadorGanhaAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,AtkAtacante,AtkAtacada,IndexJ,IndexI) :-
    Diferenca is AtkAtacante - AtkAtacada,
    VidaI1 is VidaI - Diferenca,
    retiraCartaIndex(CampoI,IndexI,0,CampoI1),
    printCampo(VidaJ,VidaI1,CampoI1,CampoJ,MaoJ,DeckJ),
    add(AtacouJ,IndexJ,AtacouJ1),
    write('\nSua carta ganhou a batalha . A carta do oponente foi destruida e a vida dele diminuiu em -'), writeln(Diferenca),
    testaVitoria([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ1,DerrJ],[NomeI,DeckI,VidaI1,MaoI,CampoI1],JogR).

jogadorPerdeAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,AtkAtacante,AtkAtacada,IndexJ) :-
    Diferenca is AtkAtacada - AtkAtacante,
    VidaJ1 is VidaJ - Diferenca,
    retiraCartaIndex(CampoJ,IndexJ,0,CampoJ1),
    printCampo(VidaJ1,VidaI,CampoI,CampoJ1,MaoJ,DeckJ),
    write('\nSua carta perdeu a batalha . A sua carta foi destruida e a sua vida diminuiu em -'), writeln(Diferenca),
    testaVitoria([NomeJ,ColJ,DeckJ,VidaJ1,MaoJ,CampoJ1,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR).

empate([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,IndexJ,IndexI) :-
    retiraCartaIndex(CampoJ,IndexJ,0,CampoJ1),
    retiraCartaIndex(CampoI,IndexI,0,CampoI1),
    printCampo(VidaJ,VidaI,CampoI1,CampoJ1,MaoJ,DeckJ),
    writeln('\nAs cartas tem o mesmo nivel de forca e empataram, as duas foram destruidas'),
    menuBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ1,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI1],JogR).

isCampoVazio([]).
isCampoVazio([H|T]) :-
    H =:= 00, isCampoVazio(T).

testaVitoria([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
        VidaJ =< 0,
        printLoose([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],JogR);
        VidaI =< 0,
        printWin([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],NomeI,JogR);
        menuBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR).


printLoose([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],JogR) :-
    writeln('\n----------------------------You Loose-----------------------------'),
    writeln('\n-----------------------Sua vida chegou a 0------------------------\n'),
    JogR = [NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ].

printLoose0([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],JogR) :-
    writeln('\n----------------------------You Loose-----------------------------'),
    writeln('\n----------------------Suas cartas acabaram------------------------\n'),
    JogR = [NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ].

printWin([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],NomeI,JogR) :-
    writeln('\n--------------------------------You Win-----------------------------------\n'),
    write('\n------------------Voce derrotou o '), write(NomeI), write('º Periodo -----------------\n'),
    writeln('\n-------------------------Voce ganhou as cartas----------------------------\n'),
    dropar(NomeI,C1, C2, C3),
    printCarta(C1), nl,
    printCarta(C2), nl,
    printCarta(C3), nl,
    add(DerrJ,NomeI,DerrJ1),
    add(ColJ,C1,ColJ1),add(ColJ1,C2,ColJ2), add(ColJ2,C3,ColJ3),
    JogR = [NomeJ,ColJ3,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ1].

erroCartaAtacou([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ,DeckJ),
    writeln('\nA carta que voce escolheu ja atacou... se ja atacou com todas termine seu turno'),
    menuBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR).

erroCartaVazia([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ,DeckJ),
    writeln('\nVoce nao escolheu uma carta... escolha novamente'),
    menuBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR).
    
add(L,X,[X|L]).

trocaCarta([],_,_,[]) :- !. 
trocaCarta([H|T],H,Carta,L1) :- L1 = [Carta|T].
trocaCarta([H|T],X,Carta,[H|L1]) :- trocaCarta(T,X,Carta,L1).


trocaCartaIndex([],_,_,_,[]) :- !. 
trocaCartaIndex([_|T],X,X,Carta,L1) :- L1 = [Carta|T].
trocaCartaIndex([H|T],X,N,Carta,[H|L1]) :- 
    N1 is N + 1,
    trocaCartaIndex(T,X,N1,Carta,L1).

retiraCartaIndex([],_,_,[]) :- !. 
retiraCartaIndex([_|T],X,X,L1) :- L1 = [00|T].
retiraCartaIndex([H|T],X,N,[H|L1]) :- 
    N1 is N + 1,
    retiraCartaIndex(T,X,N1,L1). 

retiraCarta([],_,[]) :- !. 
retiraCarta([X|T],X,L1) :- L1 = [00|T].
retiraCarta([H|T],X,[H|L1]) :- retiraCarta(T,X,L1). 

printCarta(IdCarta) :- 
    IdCarta =:= 00, write('|------Slot Vazio------|')
    ;
    IdCarta < 10, carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write('   | '), write('Ataque: '), write(Ataque), write(' | '), write('Nome: '), write(Nome)
    ;
    IdCarta < 100, carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write('  | '), write('Ataque: '), write(Ataque), write(' | '), write('Nome: '), write(Nome)
    ;
    carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write(' | '), write('Ataque: '), write(Ataque), write(' | '), write('Nome: '), write(Nome).

menuInvoc(Mao) :- 
    nth0(0,Mao,Mao1), nth0(1,Mao,Mao2), nth0(2,Mao,Mao3), nth0(3,Mao,Mao4), nth0(4,Mao,Mao5),
    writeln(''),
    writeln('#-------------------Menu de Invocacao------------------#'),
    writeln(''),
    writeln('#------------Estas sao as cartas da sua mao------------#'),
    writeln(''),
    write('[1] -> '), printCarta(Mao1),nl,
    write('[2] -> '), printCarta(Mao2),nl,
    write('[3] -> '), printCarta(Mao3),nl,
    write('[4] -> '), printCarta(Mao4),nl,
    write('[5] -> '), printCarta(Mao5),nl,
    writeln(''),
    writeln('Escolha uma carta: ').

printMenuAtaqueOpcoes() :-
    writeln('\n #-----------------Menu de Ataque---------------#'),
    writeln('\n #----------------O que quer fazer?-------------#\n'),
    writeln('[1] -> Atacar'),
    writeln('[2] -> Terminar Turno'),
    writeln('\nEscolha uma opcao: ').

printAtacou(Index,Atacou) :-
    member(Index,Atacou),
    writeln(' |---------Ja Atacou--------|');
    writeln(' |--------Nao Atacou--------|').

printMenuAtaque(Cartas) :- 
    nth0(0,Cartas,Carta1), nth0(1,Cartas,Carta2),nth0(2,Cartas,Carta3), nth0(3,Cartas,Carta4), nth0(4,Cartas,Carta5),
    
    writeln('\n #---------Estas sao as cartas do seu campo---------#\n'),
    write('[1] -> '), printCarta(Carta1),nl,
    write('[2] -> '), printCarta(Carta2),nl,
    write('[3] -> '), printCarta(Carta3),nl,
    write('[4] -> '), printCarta(Carta4),nl,
    write('[5] -> '), printCarta(Carta5),nl,
    write('\nEscolha uma carta: ').

printMenuAtaqueCampo(CartasJ,CartasI,Atacou) :- 
    nth0(0,CartasJ,Carta1J), nth0(1,CartasJ,Carta2J), nth0(2,CartasJ,Carta3J), nth0(3,CartasJ,Carta4J), nth0(4,CartasJ,Carta5J),
    nth0(0,CartasI,Carta1I), nth0(1,CartasI,Carta2I), nth0(2,CartasI,Carta3I), nth0(3,CartasI,Carta4I), nth0(4,CartasI,Carta5I),
    writeln('\n #---------Estas sao as cartas do campo do inimigo---------#\n'),
    write('[1] -> '), printCarta(Carta1I),nl,
    write('[2] -> '), printCarta(Carta2I),nl,
    write('[3] -> '), printCarta(Carta3I),nl,
    write('[4] -> '), printCarta(Carta4I),nl,
    write('[5] -> '), printCarta(Carta5I),nl,
    writeln('\n #-------------Estas sao as cartas do seu campo------------#\n'),
    write('[1] -> '), printCarta(Carta1J), printAtacou(0,Atacou),
    write('[2] -> '), printCarta(Carta2J), printAtacou(1,Atacou),
    write('[3] -> '), printCarta(Carta3J), printAtacou(2,Atacou),
    write('[4] -> '), printCarta(Carta4J), printAtacou(3,Atacou),
    write('[5] -> '), printCarta(Carta5J), printAtacou(4,Atacou). 

menuCampoCheio(Cartas) :-
    writeln('Seu campo esta cheio, escolha uma carta para retirar'),
    printMenuAtaque(Cartas).
    
geraDeckEmbaralhado([],[]).
geraDeckEmbaralhado(Deck,R) :- 
    cartaAleatoria(Deck,Carta),
    remove(Deck,Carta,Deck1),
    
    geraDeckEmbaralhado(Deck1,Rec),
    append([Carta],Rec,R).
    
cartaAleatoria([R],R).
cartaAleatoria(Deck,R) :-
    length(Deck,Len),
    Len1 is Len -1,
    Ran is random(Len1),
    nth0(Ran,Deck,R).

remove([],_,[]) :- !.
remove([X|T],X,T).
remove([H|T],X,[H|L1]) :- remove(T,X,L1).

removeIndex([],_,_,[]) :- !.
removeIndex([_|T],X,X,L1) :- L1 = T.
removeIndex([H|T],X,N,[H|L1]) :-
    N1 is N + 1,
    removeIndex(T,X,N1,L1).

printLinhaCartas([]) :- !.
printLinhaCartas([H|T]) :- 
    H =:= 00, write('|  '), write('xxx'), write('  |'), printLinhaCartas(T);
    H < 10, write('|   '), write(H), write('   |'), printLinhaCartas(T);
    H < 100, write('|  '), write(H), write('   |'), printLinhaCartas(T);
    write('|  '), write(H), write('  |'), printLinhaCartas(T).

printCampo(VidaJ,VidaI,CampoI,CampoJ,Mao,Deck) :-
    nl,
    nl,
    length(Deck,Len),
    write('Cartas no Deck = '), writeln(Len),
    write('Vida Jogador = '), writeln(VidaJ), write('Vida Oponente = '), writeln(VidaI),
    printCampoOponente(CampoI),
    printCampoJogador(CampoJ),
    printMao(Mao).

printCampoOponente(Cartas) :-
    writeln(''),
    writeln('--------------Campo de Batalha---------------'),
    writeln(''),
    writeln('|||||||||||||||||||||||||||||||||||||||||||||'),
    writeln('|       ||       ||       ||       ||       |'),
    printLinhaCartas(Cartas), writeln(''),
    writeln('|       ||       ||       ||       ||       |'),
    writeln('|||||||||||||||||||||||||||||||||||||||||||||').

printCampoJogador(Cartas) :-
    writeln('|||||||||||||||||||||||||||||||||||||||||||||'),
    writeln('|       ||       ||       ||       ||       |'),
    printLinhaCartas(Cartas), writeln(''),
    writeln('|       ||       ||       ||       ||       |'),
    writeln('|||||||||||||||||||||||||||||||||||||||||||||'),
    writeln('').

printMao(Cartas) :-
    write('-------------------Sua Mao-------------------'),
    writeln(''),
    writeln('|||||||||||||||||||||||||||||||||||||||||||||'),
    writeln('|       ||       ||       ||       ||       |'),
    printLinhaCartas(Cartas), writeln(''),
    writeln('|       ||       ||       ||       ||       |'),
    writeln('|||||||||||||||||||||||||||||||||||||||||||||').


%batalha oponente

logicaAtaque(0,_,-1).
logicaAtaque(_Carta, [], -1).
logicaAtaque(_Carta,Lista,-2):- isCampoVazio(Lista).
logicaAtaque(Carta, Lista, R):- achaMenor(Carta,Lista,R), R =\= -1; R = -1.

achaMenor(_Carta,[],-1).
achaMenor(Carta,[X|Xs],R):- carta(Carta,_,Atk1), carta(X,_,Atk2), Atk1 > Atk2, R = X;
    achaMenor(Carta,Xs,R).

maiorAtaque([], R, R).
maiorAtaque([X|Xs], WK, R):- carta(X,_,Atk1), carta(WK,_,Atk2), Atk1 > Atk2, maiorAtaque(Xs, X, R).
maiorAtaque([X|Xs], WK, R):- carta(X,_,Atk1), carta(WK,_,Atk2), Atk1 =< Atk2, maiorAtaque(Xs, WK, R).
maiorAtaque([X|Xs], R):- maiorAtaque(Xs, X, R).


ordenaCampo(List,Sorted):- q_sort(List,[],Sorted).

q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
    pivoting(H,T,L1,L2),
    q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

pivoting(_H,[],[],[]).
pivoting(H,[X|T],[X|L],G):- carta(H,_,Atk1), carta(X,_,Atk2), Atk2 =< Atk1,pivoting(H,T,L,G).
pivoting(H,[X|T],L,[X|G]):- carta(H,_,Atk1), carta(X,_,Atk2), Atk2 > Atk1,pivoting(H,T,L,G).


temVazia([], 0).
temVazia([00|_Xs], 1).
temVazia([_X|Xs], R):- temVazia(Xs, R).

drawOuNao([NomeI,DeckI,VidaI,MaoI,CampoI], R):- temVazia(MaoI, Tem), Tem =:= 1, draw(DeckI,MaoI,Mao1,Deck1),
    R = [NomeI,Deck1,VidaI,Mao1,CampoI]; R = [NomeI,DeckI,VidaI,MaoI,CampoI].


ataqueCarta(-1, _CartaI, CampoJ, VidaJ, VidaJ, CampoJ). 
ataqueCarta(-2, CartaI, CampoJ, VidaJ, VidaJn, CampoJ):- carta(CartaI,_,Atk), VidaJn is VidaJ - Atk,nl,
write('o oponente atacou diretamente, você perdeu '), write(Atk), write(' de vida.'), nl.
ataqueCarta(Id, CartaI, CampoJ, VidaJ, VidaJn, CampoJn):- carta(CartaI,_,AtkI), carta(Id,_,AtkJ),Id =\=0,
    VidaJn is (VidaJ -(AtkI - AtkJ)), trocaCarta(CampoJ,Id, 00,CampoJn), K is AtkI - AtkJ,nl,
    write('O oponente destruiu sua carta e você perdeu '), write(K), write(' pontos de vida'), nl.

ataqueInimigo(Jog, [], Jog):- Jog = [_NomeJ,_ColJ,_DeckJ,_VidaJn,_MaoJ,_CampoJn,_AtacouJ,_DerrJ].
ataqueInimigo([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[Ci|Cin], Jog):-
    ordenaCampo(CampoJ, CampoJO),
    logicaAtaque(Ci, CampoJO, Id),
    ataqueCarta(Id, Ci, CampoJ, VidaJ, VidaJn, CampoJn),
    ataqueInimigo([NomeJ,ColJ,DeckJ,VidaJn,MaoJ,CampoJn,AtacouJ,DerrJ], Cin, Jog).

testaVitoriaOponente([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR, IniR) :-
    VidaJ =< 0,
    printLoose([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],JogR);
    JogR = [NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,[],DerrJ],
    IniR = [NomeI,DeckI,VidaI,MaoI,CampoI].
    


attCampo(Carta, Campo, CampoNovo):- temVazia(Campo, R), R =:= 1, trocaCarta(Campo,00, Carta, CampoNovo);
CampoNovo = Campo.


batalhaInimigo([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI], JogNew, IniNew):- 
   drawOuNao([NomeI,DeckI,VidaI,MaoI,CampoI], [NomeI,DeckI,VidaI,MaoI1,CampoI]),
   maiorAtaque(MaoI1, Maior), 
   trocaCarta(MaoI1,Maior, 00,MaoI2),
   attCampo(Maior, CampoI, CampoI1),
   ordenaCampo(CampoI1, CampoOrd),
   printCampo(VidaJ,VidaI,CampoI1,CampoJ,MaoJ,DeckJ),
   ataqueInimigo([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ], CampoOrd, [NomeJAtt,ColJAtt,DeckJAtt,VidaJAtt,MaoJAtt,CampoJAtt,AtacouJAtt,DerrJAtt]),
   testaVitoriaOponente([NomeJAtt,ColJAtt,DeckJAtt,VidaJAtt,MaoJAtt,CampoJAtt,AtacouJAtt,DerrJAtt],[NomeI,DeckI,VidaI,MaoI2,CampoI1],JogNew,IniNew).

% inimigos e drops

inimigo(1,[2, 2, 7, 11, 12, 12, 22, 23, 2, 5, 7, 11, 12, 23, 22, 23, 5, 7, 5, 11], 8000,[],[]).
inimigo(2,[1, 3, 4, 6, 24, 21, 20, 18, 17, 16, 15, 14, 13, 10, 9, 8, 6, 4, 1, 3], 8000,[],[]).
inimigo(3,[27, 28, 29, 31, 32, 33, 34, 35, 37, 40, 43, 46, 48, 50, 51, 52, 28, 35, 27, 32], 8000,[],[]).
inimigo(4,[53, 49, 47, 45, 44, 42, 41, 39, 38, 36, 30, 26, 25, 53, 49, 47, 45, 44, 42, 41], 8000,[],[]).
inimigo(5,[54, 56, 57, 59, 60, 61, 62, 63, 64, 66, 67, 68, 69, 71, 54, 56, 57, 59, 60, 61], 8000,[],[]).
inimigo(6,[75, 74, 73, 72, 70, 65, 58, 55, 56, 67, 75, 74, 73, 72, 70, 65, 58, 55, 56, 67], 8000,[],[]).
inimigo(7,[76, 77, 78, 81, 84, 85, 88, 89, 94, 76, 77, 78, 81, 84, 85, 88, 89, 94, 76, 77], 8000,[],[]).
inimigo(8,[79, 82, 83, 80, 86, 87, 90, 91, 92, 93, 95, 79, 82, 83, 80, 86, 87, 90, 91, 92, 93], 8000,[],[]).
inimigo(9,[96,97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 96, 97, 98, 99, 100, 101], 8000,[],[]).


drops(1,[1,7, 8,9,10, 2, 3, 4, 5,6,12, 13, 14,15, 16, 11, 17, 18, 19,20, 21, 22, 23, 24, 25, 26, 27]).

drops(2,[1,7, 8,9,10, 2, 3, 4, 5,6,12, 13, 14,15, 16, 11, 17, 18, 19,20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 33]).

drops(3,[25, 26, 27, 28, 29, 30, 31, 32, 34, 33,35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46,47, 48, 49, 50, 51, 52, 41, 54, 55, 56]).

drops(4,[25, 26, 27, 28, 29, 30, 31, 32, 34, 33,35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46,47, 48, 49, 50, 51, 52, 41, 54, 55, 56, 54, 55, 56, 57, 58, 59, 60, 61, 62,63, 64, 65, 66]).

drops(5, [54, 55, 56, 57, 58, 59, 60, 61, 62,63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78]).

drops(6, [crise, ead, prazo, 57, 58, 59, 60, 61, 62,63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85]).

drops(7, [76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 98]).

drops(8, [76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 98,96, 98, 97, 99, 100, 101, 102]).

drops(9, [96, 97, 98, 99, 100, 101, 102,103, 104, 105, 106, 107, 108, 109, 76,77, 78, 79, 80, 81, 82]).


dropar(Ini,C1,C2,C3):- drops(Ini, Lista),
    geraDeckEmbaralhado(Lista, Embaralhado),
    cartaAleatoria(Embaralhado, C1), 
    cartaAleatoria(Embaralhado, C2),
    cartaAleatoria(Embaralhado, C3).

%Cartas
carta(0,"vazia",0).
carta(1,"se perdeu no campus",900).
carta(2, "matematica basica", 500).
carta(3, "Empolgação", 900).
carta(4, "Fome", 800).
carta(5, "Perdeu o onibus", 600).
carta(6, "Esquecimento", 800).
carta(7, "Aprender python", 700).
carta(8, "FUND. DE MATEMATICA P/ C. DA COMPUTAÇÃO I", 800).
carta(9, "FUND. DE MATEMATICA P/ C. DA COMPUTAÇÃO II", 900).
carta(10, "Calculo I", 900).
carta(11, "fe", 700).
carta(12, "Reposição Programação 1", 700).
carta(13, "programação 2", 800).
carta(14, "Reposição programação 2", 900).
carta(15, "Monitor de programação 1", 800).
carta(16, "Monitor de programação 2", 1000).
carta(17, "uniao", 800).
carta(18, "conselho estudantil", 1000).
carta(19, "professora livia", 750).
carta(20, "professor galdencio manso", 900).
carta(21, "professor jose fernando", 950).
carta(22, "eanes em estado de benevolencia", 500).
carta(23, "professor robertkalley", 500).
carta(24, "aluno ze fuinha", 1050).

%cartas 3 4 periodo
carta(25, "calculo II", 1400).
carta(26, "Aprender Haskell", 1500).
carta(27, "Sono na aula", 1100).
carta(28, "cola errada", 1150).
carta(29, "Video aula de Grafos", 1250).
carta(30, "Algebra Linear", 1450).
carta(31, "EDA", 1200).
carta(32, "Reposição de EDA (Dalba não perdoará)", 1200).
carta(33, "LEDA", 1200).
carta(34, "Reposição de LEDA", 1200).
carta(35, "Banco de Dados 1", 1100).
carta(36, "Preguiça", 1500).
carta(37, "Roubo", 1250).
carta(38, "Namoro", 1400).
carta(39, "Sagui", 1400).
carta(40, "Professor Luiz Antonio", 1200).
carta(41, "Professor Adalberto", 1450).
carta(42, "Professor Killer", 1500).
carta(43, "Professora Patricia Duarte", 1000).
carta(44, "nervosismo", 1500).
carta(45, "Professor Claudio Campelo", 1400).
carta(46, "Professora Areli", 1100).
carta(47, "Professor rohit", 1500).
carta(48, "professora joseane", 1200).
carta(49, "professor elmar", 1500).
carta(50, "professor everton", 1300).
carta(51, "Professora Melina", 1300).
carta(52, "Professor Fabio Jorge", 1350).
carta(53, "Professor Substituto", 1500).

% Cartas 5 6 periodo
carta(54, "A crise do meio do curso", 1650).
carta(55, "o curso agora é EAD", 1900).
carta(56, "Trabalho com prazo curto", 1800).
carta(57, "Escolher as optativas do 6 periodo", 1600).
carta(58, "Voce esta perdido no curso", 1900).
carta(59, "Estatistica Aplicada", 1600).
carta(60, "Engenharia de software", 1700).
carta(61, "Reposição de Estatistica Aplicada", 1700).
carta(62, "Reposição de Engenharia de Software", 1800).
carta(63, "Inteligencia Artificial", 1800).
carta(64, "Pato", 1700).
carta(65, "Gato", 2000).
carta(66, "Cachorro", 1700).
carta(67, "Metodologia Cientifica", 1800).
carta(68, "wi fi", 1600).
carta(69, "Desmotivação", 1600).
carta(70, "Depressao", 1950).
carta(71, "cachaça de oro", 1600).
carta(72, "ritalina", 2000).
carta(73, "aluno queridinho pelo prof", 1900).
carta(74, "aluno resiliente", 2000).
carta(75, "aluno motivado pelo odio", 2020).

% Cartas 7 8 periodo
carta(76, "Ir para a aula de ressaca", 2100).
carta(77, "Trabalho em grupo", 2150).
carta(78, "Treta no lcc2", 2250).
carta(79, "Seu Pc quebrou, poxa", 2455).
carta(80, "3 provas no mesmo dia", 2500).
carta(81, "compiladores", 2100).
carta(82, "Projeto em computação 1", 2500).
carta(83, "Estagio", 2400).
carta(84, "Reposição de compiladores", 2200).
carta(85, "Sorte", 2100).
carta(86, "Amizade", 2400).
carta(87, "Vicio", 2500).
carta(88, "Iguana", 2200).
carta(89, "Dor de cabeca", 2300).
carta(90, "aluno cheirador (aspirador fica pra traz)", 2400).
carta(91, "aluno que adquiriu loucura ao longo do tempo, mas uma genialidade incrivel", 2501).
carta(92, "professor Francisco Brasileiro", 2500).
carta(93, "aluno que apesar das adversidades persistiu ate agora", 2400).
carta(94, "aluno que sofreu mutações devido a exposição demasiada a radiação no lcc2", 2100).
carta(95, "Professor gaudencio possuido pelo espirito de ira", 2505).

% Cartas 9 periodo
carta(96, "Colação de grau", 2700).
carta(97, "formatura o zoi da Cara", 2800).
carta(98, "Gonorreia", 2650).
carta(99, "Projeto em computação 2", 2700).
carta(100, "Emprego", 2900).
carta(101, "Laguinho", 2500).
carta(102, "Greve", 2700).
carta(103, "Fim do Mundo", 2900).
carta(104, "Insonia", 2700).
carta(105, "Jacare", 2800).
carta(106, "aluno procurando emprego antes de se formar", 2600).
carta(107, "aluno poliglota", 2950).
carta(108, "aluno contratado como dev pleno sem nunca ter trabalhado", 3050).
carta(109, "aluno que fracassou em tudo e adiquiriu resistencias incriveis", 2600).

%deck e etc

deck(Jogador):- exibeDeck(Jogador),
    opcoesDeck(OpcaoDeck), 
    gerenciaDeck(OpcaoDeck, Jogador).

exibeDeck(Jogador):- Jogador = [_,_,Deck,_,_,_,_,_],
    printMDeck(),
    printCartas(Deck).

printMDeck():- writeln('        #   DECK    #       '), nl.

printMColecao():- writeln('        #   COLEÇÃO    #       '), nl.

printCartas([]):- writeln('').
printCartas([Cab|Cal]):- printCarta(Cab),nl, printCartas(Cal).

opcoesDeck(OpcaoDeck):-
    writeln('[1] -> vizualizar coleção. '),
    writeln('[2] -> remover carta do deck '),
    writeln('[3] -> voltar'), read(OpcaoDeck).

opcoesColecao(OpcaoColecao):- 
    writeln('[1] -> adicionar carta ao deck '),
    writeln('[2] -> deck'), read(OpcaoColecao).

removeAdd(Jogador,Carta, R):- Jogador = [Nome, Colecao, Deck, Vida,Mao,Campo,Atacou,Derr], 
    member(Carta, Deck), add(Colecao, Carta, NovaColecao),
    remove(Deck, Carta, NovoDeck),
    R = [Nome, NovaColecao, NovoDeck, Vida,Mao,Campo,Atacou,Derr], nl,
    writeln('Carta removida do deck!'), nl.

removeAdd(Jogador,_, Jogador):- nl, writeln('Você não possui esta carta.'), nl. 

gerenciaDeck(1, Jogador):- printMColecao(),
    exibeColecao(Jogador),
    opcoesColecao(OpcaoColecao),
    gerenciaColecao(OpcaoColecao, Jogador).

gerenciaDeck(2, Jogador):- writeln('Id da carta: '),
    read(Id),
    removeAdd(Jogador, Id, NovoJogador), deck(NovoJogador).

gerenciaDeck(3, Jogador):- Jogador = [_,_,Deck,_,_,_,_,_],
    length(Deck, Len), Len < 20, nl, 
    writeln('Deck incompleto, tenha 20 cartas no deck para voltar.'), nl,
    deck(Jogador).

gerenciaDeck(3, Jogador):- menu(Jogador). 

gerenciaDeck(_,Jogador):- nl, writeln('Opção inválida.'),nl, deck(Jogador).

exibeColecao(Jogador):- Jogador = [_,Colecao, _, _,_,_,_,_], printCartas(Colecao).

addRemove(Jogador,Carta, R):- Jogador = [Nome, Colecao, Deck, Vida,Mao,Campo,Atacou,Derr],
    member(Carta, Colecao), add(Deck, Carta, NovoDeck),
    remove(Colecao, Carta, NovaColecao),
    R = [Nome, NovaColecao, NovoDeck, Vida,Mao,Campo,Atacou,Derr], nl,
    writeln('Carta adicionada ao deck!'), nl.

addRemove(Jogador,_, Jogador):-nl,  writeln('Você não possui esta carta.'), nl. 

gerenciaColecao(1, Jogador):- Jogador = [_,_,Deck,_,_,_,_,_],
    length(Deck, Len), Len =:= 20,nl,
    writeln('Deck cheio, remova uma carta antes de adicionar outra.'),nl,
    gerenciaDeck(1, Jogador).

gerenciaColecao(1, Jogador):- writeln('Id da carta: '),
    read(Id),
    addRemove(Jogador,Id, NovoJogador),
    deck(NovoJogador).

gerenciaColecao(2, Jogador):- deck(Jogador).

gerenciaColecao(_,Jogador):- nl, writeln('Opção inválida.'),nl,
    gerenciaDeck(1, Jogador).




