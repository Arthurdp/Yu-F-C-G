deck(Jogador):- exibeDeck(Jogador), opcoesDeck(OpcaoDeck), gerenciaDeck(OpcaoDeck, Jogador).

exibeDeck(Jogador):- deckJogador(Jogador, Deck), printMDeck(), printCartas(Deck).

deckJogador(Jogador, Deck):- Jogador = [_,_,Deck,_,_,_,_].

colecaoJogador(Jogador, Colecao):- Jogador = [_,Colecao,_,_,_,_,_].

printMDeck():- writeln('        #   DECK    #       '), nl.

printMColecao():- writeln('        #   COLEÇÃO    #       '), nl.

printCartas([]):- writeln('').
printCartas([Cab|Cal]):- printCarta(Cab), printCartas(Cal).

printCarta(IdCarta):- carta(IdCarta, Nome, Ataque),
    write('Id: '), write(IdCarta), write(' | '), write('Nome: '), write(Nome),
    write(' | '), write('Ataque: '), write(Ataque), writeln(' | ').

opcoesDeck(OpcaoDeck):- writeln('[1] -> vizualizar coleção. '),
    writeln('[2] -> remover carta do deck '),
    writeln('[3] -> voltar'), read(OpcaoDeck).

opcoesColecao(OpcaoColecao):- writeln('[1] -> adicionar carta ao deck '),
    writeln('[2] -> deck'), read(OpcaoColecao).

removeAdd(Jogador,Carta, R):- Jogador = [_, Colecao, Deck, _,_,_,_], member(Carta, Deck),
    add(Colecao, Carta, NovaColecao), remove(Deck, Carta, NovoDeck),
    R = [_, NovaColecao, NovoDeck, _,_,_,_], nl,writeln('Carta removida do deck!'), nl.

removeAdd(Jogador,_, Jogador):- nl, writeln('Você não possui esta carta.'), nl. 

gerenciaDeck(1, Jogador):- printMColecao(), exibeColecao(Jogador),
    opcoesColecao(OpcaoColecao), gerenciaColecao(OpcaoColecao, Jogador).

gerenciaDeck(2, Jogador):- writeln('Id da carta: '), read(Id), removeAdd(Jogador, Id, NovoJogador), deck(NovoJogador).

gerenciaDeck(3, Jogador):- Jogador = [_, _, Deck, _,_,_,_], length(Deck, Len), Len < 20, nl, 
    writeln('Deck incompleto, tenha 20 cartas no deck para voltar.'), nl, deck(Jogador).

gerenciaDeck(_,Jogador):- nl, writeln('Opção inválida.'),nl, deck(Jogador).

exibeColecao(Jogador):- colecaoJogador(Jogador, Colecao), printCartas(Colecao).

addRemove(Jogador,Carta, R):- Jogador = [_, Colecao, Deck, _,_,_,_], member(Carta, Colecao),
    add(Deck, Carta, NovoDeck), remove(Colecao, Carta, NovaColecao),
    R = [_, NovaColecao, NovoDeck, _,_,_,_], nl, writeln('Carta adicionada ao deck!'), nl.

addRemove(Jogador,_, Jogador):-nl,  writeln('Você não possui esta carta.'), nl. 

gerenciaColecao(1, Jogador):- Jogador = [_, _, Deck, _,_,_,_], length(Deck, Len), Len =:= 20,nl,
    writeln('Deck cheio, remova uma carta antes de adicionar outra.'),nl,  gerenciaDeck(1, Jogador).

gerenciaColecao(1, Jogador):- writeln('Id da carta: '), read(Id),
    addRemove(Jogador,Id, NovoJogador),deck(NovoJogador).

gerenciaColecao(2, Jogador):- deck(Jogador).

gerenciaColecao(_,Jogador):- nl, writeln('Opção inválida.'),nl, gerenciaDeck(1, Jogador).

add(L,X,[X|L]).


