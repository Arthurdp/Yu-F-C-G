main :- jog(Jogador), deck(Jogador).

deck(Jogador):- exibeDeck(Jogador), opcoesDeck(OpcaoDeck), gerenciaDeck(OpcaoDeck, Jogador).

exibeDeck(Jogador):- deckJogador(Jogador, Deck), printMDeck(), printCartas(Deck).

deckJogador(Jogador, Deck):- Jogador = [_,_,Deck,_,_,_,_].

colecaoJogador(Jogador, Colecao):- Jogador = [_,Colecao,_,_,_,_,_].

printMDeck():- writeln('        #   DECK    #       '), nl.

printMColecao():- writeln('        #   COLEÇÃO    #       '), nl.

printCartas([]):- writeln('').
printCartas([Cab|Cal]):- printCarta(Cab), printCartas(Cal).

printCarta(IdCarta):- carta(IdCarta, Nome, Ataque,_),
    write('Id: '), write(IdCarta), write(' | '), write('Nome: '), write(Nome),
    write(' | '), write('Ataque: '), write(Ataque), writeln(' | ').

opcoesDeck(OpcaoDeck):- writeln('[1] -> vizualizar coleção. '),
    writeln('[2] -> remover carta do deck '),
    writeln('[3] -> voltar'), read(OpcaoDeck).

opcoesColecao(OpcaoColecao):- writeln('[1] -> adicionar carta ao deck '),
    writeln('[2] -> deck'), read(OpcaoColecao).

gerenciaDeck(1, Jogador):- printMColecao(), exibeColecao(Jogador), opcoesColecao(OpcaoColecao), gerenciaColecao(OpcaoColecao, Jogador).

gerenciaDeck(2, _):- write('carta remove.').

gerenciaDeck(3, _):- write('menu').

exibeColecao(Jogador):- colecaoJogador(Jogador, Colecao), printCartas(Colecao).

gerenciaColecao(1, _):- write('carta add').

gerenciaColecao(2, Jogador):- deck(Jogador).

jog(Jogador):- Jogador = ['exemplo', [2, 3], [1], 8000, [], [], []].  

carta(1, 'p1', 100, 0).
carta(2, 'p2', 200, 0).
carta(3, 'p3', 300, 0).
carta(4, 'p4', 400, 0).
