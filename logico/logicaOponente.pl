%logicaAtaque

carta(1,'corno',10).
carta(2,'cornoo',100).
carta(3,'cornooo',1000).
carta(4,'cornoooo',10000).

logicaAtaque(0,_,0).
logicaAtaque(_Carta,[],0). 
logicaAtaque(Carta, Mao, R):- maiorAtaque(Mao,K), carta(Carta,_,Atk1), carta(K,_,Atk2), Atk1 > Atk2, R = K.
logicaAtaque(Carta, [C1|_Cn], R):- testaCartas(Carta,C1,R), R =\= 0.
logicaAtaque(Carta,[_C1|Cn],Result):- logicaAtaque(Carta,Cn,Result ).

testaCartas(IdI, IdJog, IdJog):- carta(IdI,_,AtaqueI), carta(IdJog,_,AtaqueJog),
AtaqueI > AtaqueJog.
testaCartas(IdI, IdJog, 0):- carta(IdI,_,AtaqueI), carta(IdJog,_,AtaqueJog),
AtaqueI < AtaqueJog.

maiorAtaque([], R, R).
maiorAtaque([X|Xs], WK, R):- carta(X,_,Atk1), carta(WK,_,Atk2), Atk1 > Atk2, maiorAtaque(Xs, X, R).
maiorAtaque([X|Xs], WK, R):- carta(X,_,Atk1), carta(WK,_,Atk2), Atk1 =< Atk2, maiorAtaque(Xs, WK, R).
maiorAtaque([X|Xs], R):- maiorAtaque(Xs, X, R).


main :-
    logicaAtaque(2,[2,3,3,2],R),
    write(R).

