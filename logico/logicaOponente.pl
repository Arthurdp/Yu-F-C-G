%logicaAtaque
carta(00,'corno',0).
carta(1,'corno',1).
carta(2,'cornoo',10).
carta(3,'cornooo',100).
carta(4,'cornoooo',1000).

logicaAtaque(0,_,-1).
logicaAtaque(_Carta,[],-2).
logicaAtaque(_Carta,Lista,-2):- isCampoVazio(Lista).
logicaAtaque(Carta, CampoJ, R):- maiorAtaque(CampoJ,K), carta(Carta,_,Atk1), carta(K,_,Atk2), Atk1 > Atk2, R is K.
logicaAtaque(Carta, [C1|_Cn], R):- testaCartas(Carta,C1,R), R =\= 0.
logicaAtaque(Carta,[_C1|Cn],Result):- logicaAtaque(Carta,Cn,Result ).

testaCartas(IdI, IdJog, IdJog):- carta(IdI,_,AtaqueI), carta(IdJog,_,AtaqueJog),
AtaqueI > AtaqueJog.
testaCartas(IdI, IdJog, -1):- carta(IdI,_,AtaqueI), carta(IdJog,_,AtaqueJog),
AtaqueI < AtaqueJog.

maiorAtaque([], R, R).
maiorAtaque([X|Xs], WK, R):- carta(X,_,Atk1), carta(WK,_,Atk2), Atk1 > Atk2, maiorAtaque(Xs, X, R).
maiorAtaque([X|Xs], WK, R):- carta(X,_,Atk1), carta(WK,_,Atk2), Atk1 =< Atk2, maiorAtaque(Xs, WK, R).
maiorAtaque([X|Xs], R):- maiorAtaque(Xs, X, R).


ordenaCampo(List,Sorted):-q_sort(List,[],Sorted).

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
ataqueCarta(-2, CartaI, CampoJ, VidaJ, VidaJn, CampoJ):- carta(CartaI,_,Atk), VidaJn is VidaJ - Atk.
ataqueCarta(Id, _CartaI, CampoJ, VidaJ, VidaJ, CampoJn):- trocaCarta(CampoJ,Id, 00,CampoJn).

ataqueInimigo(Jog, [], Jog):- Jog = [_NomeJ,_ColJ,_DeckJ,_VidaJn,_MaoJ,_CampoJn,_AtacouJ,_DerrJ].
ataqueInimigo([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[Ci|Cin], Jog):-
    logicaAtaque(Ci, CampoJ, Id),
    ataqueCarta(Id, Ci, CampoJ, VidaJ, VidaJn, CampoJn),
    ataqueInimigo([NomeJ,ColJ,DeckJ,VidaJn,MaoJ,CampoJn,AtacouJ,DerrJ], Cin, Jog).

testaVitoriaOponente([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI],JogR) :-
    VidaJ =< 0,
    printLoose([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],JogR);
    write('Jogador ataca agr').


attCampo(Carta, Campo, CampoNovo):- temVazia(Campo, R), R =:= 1, trocaCarta(Campo,00, Carta, CampoNovo);
CampoNovo = Campo.


batalhaInimigo([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,DeckI,VidaI,MaoI,CampoI]):-
   drawOuNao([NomeI,DeckI,VidaI,MaoI,CampoI], [NomeI,DeckI,VidaI,MaoI1,CampoI]),
   maiorAtaque(MaoI1, Maior), attCampo(Maior, CampoI, CampoI1), ordenaCampo(CampoI1, CampoOrd),
   ataqueInimigo([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ], CampoOrd, [NomeJAtt,ColJAtt,DeckJAtt,VidaJAtt,MaoJAtt,CampoJAtt,AtacouJAtt,DerrJAtt]),
   printCampo(VidaJAtt,VidaI,CampoI1,CampoJAtt,MaoJAtt,DeckJAtt),
    testaVitoriaOponente([NomeJAtt,ColJAtt,DeckJAtt,VidaJAtt,MaoJAtt,CampoJAtt,AtacouJAtt,DerrJAtt],[NomeI,DeckI,VidaI,MaoI,CampoI1],_JogR).



    


main :-
    Jog = ['awd',[1],[],8000,[1,2,2,1,00],[1,2,3,00,00],[],[]],
    Ini = ['corno',[4,3,3,2,1,1,2,3,2,2,3,2],8000,[4,3,3,2,1], [0,3,3,2,1]],
    batalhaInimigo(Jog,Ini).
    %write(R).


retiraCarta([],_,[]) :- !. 
retiraCarta([X|T],X,L1) :- L1 = [00|T].
retiraCarta([H|T],X,[H|L1]) :- retiraCarta(T,X,L1). 


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

printLinhaCartas([]) :- !.
printLinhaCartas([H|T]) :- 
    H =:= 00, write('|  '), write('xxx'), write('  |'), printLinhaCartas(T);
    H < 10, write('|   '), write(H), write('   |'), printLinhaCartas(T);
    H < 100, write('|  '), write(H), write('   |'), printLinhaCartas(T);
    write('|  '), write(H), write('  |'), printLinhaCartas(T).

draw([A|T],Mao,Mao1,Deck) :-
    trocaCarta(Mao,00,A,Mao1),
    Deck = T.

trocaCarta([],_,_,[]) :- !. 
trocaCarta([H|T],H,Carta,L1) :- L1 = [Carta|T].
trocaCarta([H|T],X,Carta,[H|L1]) :- trocaCarta(T,X,Carta,L1).

isCampoVazio([]).
isCampoVazio([H|T]) :-
    H =:= 00, isCampoVazio(T).

printLoose([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],JogR) :-
    writeln('\n----------------------------You Loose-----------------------------'),
    writeln('\n-----------------------Sua vida chegou a 0------------------------\n'),
    JogR = [NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ].