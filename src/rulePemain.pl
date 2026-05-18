getNextPlayer(Next) :-
    gameDirection(normal), !,
    currentPlayer(Current),
    playerOrder(Order),
    findNext(Current,Order,Next).

getNextPlayer(Next) :-
    gameDirection(reverse), !,
    currentPlayer(Current),
    playerOrder(Order),
    findPrevious(Current,Order,Next).

/* Mencari player selanjutnya jika alur normal */
findNext(Current,[Current,Next|_],Next) :- !.

findNext(Current,[_|T],Next) :-
    findNext(Current,T,Next).

findNext(Current,[Current],Next) :-
    playerOrder([Next|_]).

/* Mencari player selanjutnya jika alur reverse */
findPrevious(Current,[Next,Current|_],Next) :- !.

findPrevious(Current,[_|T],Next) :- 
    findPrevious(Current,T,Next).

findPrevious(Current,[Current|_],Next) :-
    playerOrder(Order),
    ambilElemenTerakhir(Order,Next), !.

ubahArahPermainan :-
    retract(gameDirection(normal)),
    assertz(gameDirection(reverse)),
    write('Arah giliran pemain berubah menjadi REVERSE.').

ubahArahPermainan :-
    retract(gameDirection(reverse)),
    assertz(gameDirection(normal)),
    write('Arah giliran pemain berubah menjadi NORMAL.').

ambilElemenTerakhir([X], X) :- !.
ambilElemenTerakhir([_|T],X) :-
    ambilElemenTerakhir(T,X).

