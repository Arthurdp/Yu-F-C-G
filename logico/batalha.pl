%batalha

carta(1,'corno',100).
carta(10,'corno',1000).
carta(100,'corno',10000).
carta(00,'corno',0).


main :-
    Jog = ['awd',[1],[1,10,100,100,100,1,10,100,100,100,1,10,100,100,100,1,10,100,100,100],8000,[1,10,100,00,00],[1,10,100,00,00],[],[1]],
    %trocaCarta([1,10,100,00,00],00,1,Ret),
    batalha(Jog,['awd',[1,10,10,10,10,1,10,10,10,10,1,10,10,10,10,1,10,10,10,10],8000,[],[]],Jog1),
    %writeln(Ret),
    writeln(Jog1).

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
    CampoI1 = [1,10,100,00,00], 
    geraDeckEmbaralhado(DeckJ,DeckJEm),
    geraDeckEmbaralhado(DeckI,DeckIEm),
    draw5(DeckJEm,MaoJ1,DeckDrawJ),
    draw4(DeckIEm,MaoI1,DeckDrawI),
    
    printCampo(VidaJ,VidaI,CampoI1,CampoJ1,MaoJ1),
    menuInvoc(MaoJ1),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,MaoJ1,Carta),
    trocaCarta(CampoJ1,00,Carta,CampoJ2),
    retiraCartaIndex(MaoJ1,Index,1,MaoJ2),
    
    Jog = [NomeJ,ColJ,DeckDrawJ,VidaJ,MaoJ2,CampoJ2,AtacouJ,DerrJ],
    batalhaJogador(Jog,[NomeI,DeckDrawI,VidaI,MaoI1,CampoI1],JogR1),
    %batalhaInimigo(Jog,[NomeI,DeckDrawI,VidaI,MaoI1,CampoI,DerrI],JogR1).
    JogR1 = [NomeFim,ColFim,_,_,_,_,_,DerrFim],
    JogR = [NomeFim,ColFim,DeckJ,8000,[],[],[],DerrFim].

batalhaJogador([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
    length(DeckJ,Len),
    Len =:= 0,
    printLoose([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],JogR);
    draw(DeckJ,MaoJ,MaoJ1,DeckDrawJ),
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ1),

    menuInvoc(MaoJ1),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,MaoJ1,Carta),

    meuIf(CampoJ,Carta,CampoJ1),
    
    retiraCartaIndex(MaoJ1,Index,1,MaoJ2),
    printCampo(VidaJ,VidaI,CampoI,CampoJ1,MaoJ2),
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
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ),
    menuAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR);
    %batalhaInimigo([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR).
    batalhaJogador([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR).

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
        JogR,AtkAtacante,AtkAtacada,Id,CartaI,IndexJ,Index1).

batalhaCartas([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,AtkAtacante,AtkAtacada,CartaJ,CartaI,IndexJ,IndexI) :- 
    isCampoVazio(CampoI),
    ataqueCampoVazio([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],
        [NomeI,DeckI,VidaI,MaoI,CampoI],JogR,AtkAtacante,CartaJ,IndexJ)
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
    printCampo(VidaJ,VidaI1,CampoI,CampoJ,MaoJ),
    add(AtacouJ,IndexJ,AtacouJ1),
    write('\nVoce atacou o inimigo diretamente e retirou -'), write(AtkAtacante), writeln('da vida dele!'),
    testaVitoria([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ1,DerrJ],[NomeI,DeckI,VidaI1,MaoI,CampoI],JogR).

jogadorGanhaAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,AtkAtacante,AtkAtacada,IndexJ,IndexI) :-
    Diferenca is AtkAtacante - AtkAtacada,
    VidaI1 is VidaI - Diferenca,
    retiraCartaIndex(CampoI,IndexI,0,CampoI1),
    printCampo(VidaJ,VidaI1,CampoI1,CampoJ,MaoJ),
    add(AtacouJ,IndexJ,AtacouJ1),
    write('\nSua carta ganhou a batalha . A carta do oponente foi destruida e a vida dele diminuiu em -'), writeln(Diferenca),
    testaVitoria([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ1,DerrJ],[NomeI,DeckI,VidaI1,MaoI,CampoI1],JogR).

jogadorPerdeAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,AtkAtacante,AtkAtacada,IndexJ) :-
    Diferenca is AtkAtacada - AtkAtacante,
    VidaJ1 is VidaJ - Diferenca,
    retiraCartaIndex(CampoJ,IndexJ,0,CampoJ1),
    printCampo(VidaJ1,VidaI,CampoI,CampoJ1,MaoJ),
    write('\nSua carta perdeu a batalha . A sua carta foi destruida e a sua vida diminuiu em -'), writeln(Diferenca),
    testaVitoria([NomeJ,ColJ,DeckJ,VidaJ1,MaoJ,CampoJ1,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR).

empate([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],
        JogR,IndexJ,IndexI) :-
    retiraCartaIndex(CampoJ,IndexJ,0,CampoJ1),
    retiraCartaIndex(CampoI,IndexI,0,CampoI1),
    printCampo(VidaJ,VidaI,CampoI1,CampoJ1,MaoJ),
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
    writeln('\n-----------Sua vida chegou a 0 ou suas cartas acabaram------------\n'),
    JogR = [NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ].

printWin([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],NomeI,JogR) :-
    writeln('\n--------------------------------You Win-----------------------------------\n'),
    write('\n------------------Voce derrotou o '), write(NomeI), write(' -----------------\n'),
    %%%%%%%%%%%%%%%%let card = verificaOponente oponente
    writeln('\n-------------------------Voce ganhou as cartas----------------------------\n'),
    %++ repCarta (card !! 0) write(' -------------\n')
    %++ repCarta (card !! 1) write(' -------------\n')
    %++ repCarta (card !! 2) write(' -------------\n')
    add(DerrJ,NomeI,DerrJ1),
    add(ColJ,123,ColJ1),
    JogR = [NomeJ,ColJ1,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ1].

erroCartaAtacou([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ),
    writeln('\nA carta que voce escolheu ja atacou... se ja atacou com todas termine seu turno'),
    menuBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR).

erroCartaVazia([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ),
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
    writeln('Digite sua escolha: ').

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

printCampo(VidaJ,VidaI,CampoI,CampoJ,Mao) :-
    writeln(''),
    writeln(''),
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
