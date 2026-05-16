:- use_module(library(random)).

randomList([],[]).
randomList(ListAsal,[ElemenTerpilih|SisaHasil]) :-
    length(ListAsal, Panjang),
    random(0, Panjang, Index),
    getAndRemove(Index,ListAsal,ElemenTerpilih,ListSisa),
    randomList(ListSisa,SisaHasil).

getAndRemove(0,[H|T],H,T).
getAndRemove(Index,[H|T],Elemen,[H|SisaTail]) :-
    Index > 0,
    Next is Index - 1,
    getAndRemove(Next,T,Elemen,SisaTail).
