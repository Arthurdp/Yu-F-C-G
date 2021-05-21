%batalha

carta(1,'corno',1000).
carta(2,'corno',10000).


main :-
    Jog = ['awd',[1],[1,10,100,100,100,1,10,100,100,100,1,10,100,100,100,1,10,100,100,100],8000,[1,10,100,00,00],[1,10,100,00,00],[1]],
    printCampo(8000,16356,[1,10,100,00,00],[],[]),
    retiraCarta([1,10,100,00,00],100,Ret),
    batalha(Jog,['awd',[],[1,10,100,100,100,1,10,100,100,100,1,10,100,100,100,1,10,100,100,100],800,[],[],[]],Jog1),
    writeln(Ret).



batalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,DerrI],Jog) :- 
    geraDeckEmbaralhado(DeckJ,DeckJEm),
    geraDeckEmbaralhado(DeckI,DeckIEm),


    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ),
    menuInvoc(MaoJ),
    read(Index),
    retiraCartaIndex(MaoJ,Index,1,MaoJ1),
    write(MaoJ1),
    removeIndex(MaoJ1,2,0,MaoJ2),
    write(MaoJ2).



retiraCartaIndex([],_,_,[]) :- !. 
retiraCartaIndex([_|T],X,X,L1) :- L1 is [00|T].
retiraCartaIndex([H|T],X,N,[H|L1]) :- 
    N1 is N + 1,
    retiraCartaIndex(T,X,N1,L1). 

retiraCarta([],_,[]) :- !. 
retiraCarta([X|T],X,L1) :- L1 is [00|T].
retiraCarta([H|T],X,[H|L1]) :- retiraCarta(T,X,L1). 

menuInvocaCartas(Mao) :-
    nth0(0,Mao,Mao1),
    nth0(1,Mao,Mao2),
    nth0(2,Mao,Mao3),
    nth0(3,Mao,Mao4),
    nth0(4,Mao,Mao5),
    writeln(''),
    writeln('#-----------Menu de Invocacao-----------#'),
    writeln(''),
    writeln('#-----------Estas sao as cartas da sua mao-----------#\n'),
    writeln(''),
    writeln('[1] -> '), write(Mao1),
    writeln('[2] -> '), write(Mao2),
    writeln('[3] -> '), write(Mao3),
    writeln('[4] -> '), write(Mao4),
    writeln('[5] -> '), write(Mao5),
    writeln(''),
    writeln('Digite sua escolha: ').

    
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
removeIndex([H|T],X,X,L1) :- L1 is T.
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
    write('\cVida Jogador = '), writeln(VidaJ), write('\cVida Oponente = '), writeln(VidaI),
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
    writeln(''),
    write('-------------------Sua Mao-------------------'),
    writeln(''),
    writeln('|||||||||||||||||||||||||||||||||||||||||||||'),
    writeln('|       ||       ||       ||       ||       |'),
    printLinhaCartas(Cartas), writeln(''),
    writeln('|       ||       ||       ||       ||       |'),
    writeln('|||||||||||||||||||||||||||||||||||||||||||||').
