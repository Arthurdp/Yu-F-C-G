%batalha

carta(1,'corno',1000).
carta(2,'corno',10000).



main :-
    Jog = ['awd',[],[],8000,[],[],[]],
    batalha(Jog,['awd',[],[],800,[],[],[]]).


batalha([NomeJ,ColJ,DeckJ,VidaJ,MaoJ,CampoJ,DerrJ], [NomeI,ColI,DeckI,VidaI,MaoI,CampoI,DerrI], R) :- 
    
    VidaJ > VidaI,
    writeln('Jogador ganhou'), halt;
    writeln('Jogador perdeu'), halt,
    R = [NomeJ,ColJ,DeckJ,VidaJ1,MaoJ,CampoJ,DerrJ].
    

batalhaCartas(IdJ,IdI) :- carta(IdJ,_,AtaqueJ), carta(IdI,_,AtaqueI),
    AtaqueJ > AtaqueI,
    writeln('Jogador ganhou'), halt;
    writeln('Jogador perdeu'), halt.
    