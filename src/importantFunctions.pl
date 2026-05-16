:- use_module(library(random)).

/* Mengacak sebuah list */
randomList([],[]).
randomList(ListAsal,[ElemenTerpilih|SisaHasil]) :-
    length(ListAsal, Panjang),
    Panjang > 0,
    random(0, Panjang, Index),
    getAndRemove(Index,ListAsal,ElemenTerpilih,ListSisa),
    randomList(ListSisa,SisaHasil).

getAndRemove(0,[H|T],H,T) :- !.
getAndRemove(Index,[H|T],Elemen,[H|SisaTail]) :-
    Index > 0,
    Next is Index - 1,
    getAndRemove(Next,T,Elemen,SisaTail).

/* Mengambil satu elemen dari list secara random */
getOneRandom(List,Result) :-
    List \= [],
    length(List,Panjang),
    random(0, Panjang, Index),
    getElement(Index,List,Result).

getElement(0,[H|_],H).
getElement(Index,[_|T],Elemen) :-
    Index > 0,
    NextIndex is Index - 1,
    getElement(NextIndex, T, Elemen).

/* Append */
myAppend([],Elemen,[Elemen]).
myAppend([H|T],Elemen,[H|Rest]) :-
    myAppend(T,Elemen,Rest).

/* Findall */
:- dynamic(tempResult/1).

myFindall(Template, Goal, List) :-
    (   call(Goal),
        assertz(tempResult(Template)),
        fail ;
        collectResults(List)
    ).

collectResults([H|T]) :-
    retract(tempResult(H)), !,
    collectResults(T).

collectResults([]).

% Mengambil panjang dari suatu list
getLength([], 0).
getLength([_|Tail], Length) :-
    getLength(Tail, TailLength),
    Length is Length + 1.