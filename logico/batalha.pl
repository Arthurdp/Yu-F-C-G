%batalha

carta(1,'corno',1000).
carta(10,'corno',10000).
carta(100,'corno',10000).
carta(00,'corno',10000).


main :-
    Jog = ['awd',[1],[1,10,100,100,100,1,10,100,100,100,1,10,100,100,100,1,10,100,100,100],8000,[1,10,100,00,00],[1,10,100,00,00],[1]],
    %trocaCarta([1,10,100,00,00],00,1,Ret),
    batalha(Jog,['awd',[],[1,10,100,100,100,1,10,100,100,100,1,10,100,100,100,1,10,100,100,100],800,[],[],[]],Jog1),
    %writeln(Ret),
    writeln(Jog1).

draw5([A,B,C,D,E|T],Mao,Deck) :-
    Mao = [A,B,C,D,E],
    Deck = T.

draw([A|T],Mao,Mao1,Deck) :-
    trocaCarta(Mao,00,A,Mao1),
    Deck = T.

batalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,DerrI],Jog) :- 
    CampoJ1 = [00,00,00,00,00],
    CampoI1 = [00,00,00,00,00], 
    geraDeckEmbaralhado(DeckJ,DeckJEm),
    geraDeckEmbaralhado(DeckI,DeckIEm),
    draw5(DeckJEm,MaoJ1,DeckDrawJ),
    draw5(DeckIEm,MaoI1,DeckDrawI),
    
    printCampo(VidaJ,VidaI,CampoI1,CampoJ1,MaoJ1),
    menuInvoc(MaoJ1),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,MaoJ1,Carta),
    trocaCarta(CampoJ1,00,Carta,CampoJ2),
    retiraCartaIndex(MaoJ,Index,1,MaoJ2),
    
    printCampo(VidaJ,VidaI,CampoI1,CampoJ2,MaoJ2),
    Jog = [NomeJ,ColJ,DeckDrawJ,VidaJ,MaoJ2,CampoJ2,DerrJ].

trocaCarta([],_,_,[]) :- !. 
trocaCarta([H|T],H,Carta,L1) :- L1 = [Carta|T].
trocaCarta([H|T],X,Carta,[H|L1]) :- trocaCarta(T,X,Carta,L1).

trocaCartaIndex([],_,_,[]) :- !. 
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

printCarta(IdCarta):- 
    IdCarta =:= 00, writeln('|------Slot Vazio------|'),!
    ;
    IdCarta < 10, carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write('   | '), write('Ataque: '), write(Ataque), write(' | '), write('Nome: '), write(Nome), writeln('  '),!
    ;
    IdCarta < 100, carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write('  | '), write('Ataque: '), write(Ataque), write(' | '), write('Nome: '), write(Nome), writeln('  '),!
    ;
    carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write(' | '), write('Ataque: '), write(Ataque), write(' | '), write('Nome: '), write(Nome), writeln('  '),!.

menuInvoc(Mao) :- 
    nth0(0,Mao,Mao1), nth0(1,Mao,Mao2), nth0(2,Mao,Mao3), nth0(3,Mao,Mao4), nth0(4,Mao,Mao5), 
    writeln(''),
    writeln('#-----------Menu de Invocacao-----------#'),
    writeln(''),
    writeln('#-----------Estas sao as cartas da sua mao-----------#'),
    writeln(''),
    write('[1] -> '), printCarta(Mao1),!,
    write('[2] -> '), printCarta(Mao2),!,
    write('[3] -> '), printCarta(Mao3),!,
    write('[4] -> '), printCarta(Mao4),!,
    write('[5] -> '), printCarta(Mao5),!,
    writeln(''),
    writeln('Digite sua escolha: '),!.

    
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


batalhaCartas(IdJ,IdI) :- carta(IdJ,_,AtaqueJ), carta(IdI,_,AtaqueI),
    AtaqueJ > AtaqueI,
    writeln('Jogador ganhou'), halt;
    writeln('Jogador perdeu'), halt.
    

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
