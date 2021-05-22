%batalha

carta(1,'corno',1000).
carta(10,'corno',10000).
carta(100,'corno',10000).
carta(00,'corno',10000).


main :-
    Jog = ['awd',[1],[1,10,100,100,100,1,10,100,100,100,1,10,100,100,100,1,10,100,100,100],8000,[1,10,100,00,00],[1,10,100,00,00],[],[1]],
    %trocaCarta([1,10,100,00,00],00,1,Ret),
    batalha(Jog,['awd',[],[1,10,100,100,100,1,10,100,100,100,1,10,100,100,100,1,10,100,100,100],800,[],[],[],[]],Jog1),
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

batalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR) :- 
    CampoJ1 = [00,00,00,00,00],
    CampoI1 = [00,00,00,00,00], 
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
    retiraCartaIndex(MaoJ,Index,1,MaoJ2),
    
    printCampo(VidaJ,VidaI,CampoI1,CampoJ2,MaoJ2),
    Jog = [NomeJ,ColJ,DeckDrawJ,VidaJ,MaoJ2,CampoJ2,AtacouJ,DerrJ],
    
    batalhaJogador(Jog,[NomeI,ColI,DeckDrawI,VidaI,MaoI1,CampoI,AtacouI,DerrI],JogR).
    %batalhaInimigo(Jog,[NomeI,ColI,DeckDrawI,VidaI,MaoI1,CampoI,DerrI],JogR).

batalhaJogador([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR) :-
    draw(DeckJ,MaoJ,MaoJ1,DeckDrawJ),
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ1)

    menuInvoc(MaoJ1),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,MaoJ1,Carta),

    campoCheio(CampoJ,AtacouJ,Escolha),
    trocaCarta(CampoJ1,Escolha,Carta,CampoJ2),
    retiraCartaIndex(MaoJ,Index,1,MaoJ2),
    printCampo(VidaJ,VidaI,CampoI,CampoJ2,MaoJ2),
    Jog = [NomeJ,ColJ,DeckDrawJ,VidaJ,MaoJ2,CampoJ2,AtacouJ,DerrJ],
    menuBatalha(Jog,[NomeI,ColI,DeckDrawI,VidaI,MaoI1,CampoI,AtacouI,DerrI],JogR).

campoCheio(Campo,Atacou,R) :-
    length(Campo,Len),
    Len =:= 5,
    menuCampoCheio(Campo,Atacou),Read(R);
    R is 00.

menuBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR) :-
    printMenuAtaqueOpcoes(),
    read(Op),
    leOpcaoBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],Op,JogR).

leOpcaoBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],Op,JogR) :-
    Op =:= 1,
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ),
    menuAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR);
    batalhaInimigo([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR).

menuAtaque([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR) :-
    printMenuAtaqueCampo(Campo,AtacouJ),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,MaoJ,Carta),
    testaAtacou(Carta,AtacouJ).

testaAtacou([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR,Id,Atacou,Carta) :-
    member(Id, Atacou),
    erroCartaAtacou([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR); 
    Id =:= 00,
    erroCartaVazia([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR);
    printMenuAtaqueCampoInimigo(CampoJ,CampoI,AtacouJ),
    read(Index),
    Index1 is Index-1,
    nth0(Index1,CampoI,CartaI),
    batalhaCartas([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR,Carta,CartaI).

batalhaCartas([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR,IdAtacante,IdAtacada) :- 
    carta(IdAtacante,_,AtkAtacante), carta(IdAtacada,_,AtkAtacada),
    AtaqueJ > AtaqueI,
    writeln('Jogador ganhou'), halt;
    writeln('Jogador perdeu'), halt.

erroCartaAtacou([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR) :-
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ),
    writeln('\nA carta que voce escolheu ja atacou... se ja atacou com todas termine seu turno\n'),
    menuBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR).

erroCartaVazia ([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR) :-
    printCampo(VidaJ,VidaI,CampoI,CampoJ,MaoJ),
    writeln('\nVoce nao escolheu uma carta... escolha novamente\n'),
    menuBatalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,AtacouJ,DerrJ],[NomeI,ColI,DeckI,VidaI,MaoI,CampoI,AtacouI,DerrI],JogR).
    


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

printCarta(IdCarta) :- 
    IdCarta =:= 00, writeln('|------Slot Vazio------|')
    ;
    IdCarta < 10, carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write('   | '), write('Ataque: '), write(Ataque), write(' | '), write('Nome: '), write(Nome), writeln('  ')
    ;
    IdCarta < 100, carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write('  | '), write('Ataque: '), write(Ataque), write(' | '), write('Nome: '), write(Nome), writeln('  ')
    ;
    carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write(' | '), write('Ataque: '), write(Ataque), write(' | '), write('Nome: '), write(Nome), writeln('  ').

menuInvoc(Mao) :- 
    nth0(0,Mao,Mao1), nth0(1,Mao,Mao2), nth0(2,Mao,Mao3), nth0(3,Mao,Mao4), nth0(4,Mao,Mao5), 
    writeln(''),
    writeln('#-----------Menu de Invocacao-----------#'),
    writeln(''),
    writeln('#-----------Estas sao as cartas da sua mao-----------#'),
    writeln(''),
    write('[1] -> '), printCarta(Mao1),
    write('[2] -> '), printCarta(Mao2),
    write('[3] -> '), printCarta(Mao3),
    write('[4] -> '), printCarta(Mao4),
    write('[5] -> '), printCarta(Mao5),
    writeln(''),
    writeln('Digite sua escolha: ').

printMenuAtaqueOpcoes() :-
    writeln('\n #---------------Menu de Ataque---------------#'),
    writeln('\n #---------O que quer fazer?---------#\n'),
    writeln('[1] -> Atacar'),
    writeln('[2] -> Terminar Turno'),
    writeln('\nEscolha uma opcao: ').

printAtacou(Carta,Atacou) :-
    Carta =:= Atacou,
    write('--------Ja Atacou--------');
    write('--------Nao Atacou--------').

printMenuAtaque(Cartas,Atacou) :- nth0(0,Cartas,Carta1), nth0(1,Cartas,Carta2), nth0(2,Cartas,Carta3), nth0(3,Cartas,Carta4), nth0(4,Cartas,Carta5),
    nth0(0,Atacou,Atacou1), nth0(1,Atacou,Atacou2), nth0(2,Atacou,Atacou3), nth0(3,Atacou,Atacou4), nth0(4,Atacou,Atacou5),
    writeln('\n #---------Estas sao as cartas do seu campo---------#\n'),
    writeln('[1] -> '), printCarta(Carta1),
    writeln('[2] -> '), printCarta(Carta2),
    writeln('[3] -> '), printCarta(Carta3),
    writeln('[4] -> '), printCarta(Carta4),
    writeln('[5] -> '), printCarta(Carta5),
    writeln('\nEscolha uma carta: ').

printMenuAtaqueCampo(CartasJ,CartasI,Atacou) :- 
    nth0(0,CartasJ,Carta1J), nth0(1,CartasJ,Carta2J), nth0(2,CartasJ,Carta3J), nth0(3,CartasJ,Carta4J), nth0(4,CartasJ,Carta5J),
    nth0(0,CartasI,Carta1I), nth0(1,CartasI,Carta2I), nth0(2,CartasI,Carta3I), nth0(3,CartasI,Carta4I), nth0(4,CartasI,Carta5I),
    nth0(0,Atacou,Atacou1), nth0(1,Atacou,Atacou2), nth0(2,Atacou,Atacou3), nth0(3,Atacou,Atacou4), nth0(4,Atacou,Atacou5),
    writeln('\n #---------Estas sao as cartas do campo do inimigo---------#\n'),
    writeln('[1] -> '), printCarta(Carta1I),
    writeln('[2] -> '), printCarta(Carta2I),
    writeln('[3] -> '), printCarta(Carta3I),
    writeln('[4] -> '), printCarta(Carta4I),
    writeln('[5] -> '), printCarta(Carta5I),
    writeln('\n #-------------Estas sao as cartas do seu campo------------#\n'),
    writeln('[1] -> '), printCarta(Carta1J), printAtacou(Carta1J,Atacou1),
    writeln('[2] -> '), printCarta(Carta2J), printAtacou(Carta2J,Atacou2),
    writeln('[3] -> '), printCarta(Carta3J), printAtacou(Carta3J,Atacou3),
    writeln('[4] -> '), printCarta(Carta4J), printAtacou(Carta4J,Atacou4),
    writeln('[5] -> '), printCarta(Carta5J), printAtacou(Carta5J,Atacou5),
    writeln('\nEscolha uma carta do seu campo: ').

printMenuAtaqueCampoInimigo(CartasJ,CartasI,Atacou) :- 
    nth0(0,CartasJ,Carta1J), nth0(1,CartasJ,Carta2J), nth0(2,CartasJ,Carta3J), nth0(3,CartasJ,Carta4J), nth0(4,CartasJ,Carta5J),
    nth0(0,CartasI,Carta1I), nth0(1,CartasI,Carta2I), nth0(2,CartasI,Carta3I), nth0(3,CartasI,Carta4I), nth0(4,CartasI,Carta5I),
    nth0(0,Atacou,Atacou1), nth0(1,Atacou,Atacou2), nth0(2,Atacou,Atacou3), nth0(3,Atacou,Atacou4), nth0(4,Atacou,Atacou5),
    writeln('\n #---------Estas sao as cartas do campo do inimigo---------#\n'),
    writeln('[1] -> '), printCarta(Carta1I),
    writeln('[2] -> '), printCarta(Carta2I),
    writeln('[3] -> '), printCarta(Carta3I),
    writeln('[4] -> '), printCarta(Carta4I),
    writeln('[5] -> '), printCarta(Carta5I),
    writeln('\n #-------------Estas sao as cartas do seu campo------------#\n'),
    writeln('[1] -> '), printCarta(Carta1J), printAtacou(Carta1J,Atacou1),
    writeln('[2] -> '), printCarta(Carta2J), printAtacou(Carta2J,Atacou2),
    writeln('[3] -> '), printCarta(Carta3J), printAtacou(Carta3J,Atacou3),
    writeln('[4] -> '), printCarta(Carta4J), printAtacou(Carta4J,Atacou4),
    writeln('[5] -> '), printCarta(Carta5J), printAtacou(Carta5J,Atacou5),
    writeln('\nEscolha uma carta do campo do inimigo: ').

menuCampoCheio(Cartas,Atacou) :-
    writeln('Seu campo esta cheio, escolha uma carta para retirar'),
    printMenuAtaque(Cartas,Atacou).
    
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
