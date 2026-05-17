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
    Length is TailLength + 1.

/* Sort */
mySort([], []).
mySort([H|T], Sorted) :-
    mySort(T, SortedTail),
    insert_stats(H, SortedTail, Sorted).

% insert_stats/3: Memasukkan elemen ke posisi yang tepat
insert_stats(X, [], [X]).

% Jika X harus diletakkan SEBELUM Head, maka jadikan X sebagai Head baru
insert_stats(stats(P1, K1, U1, N1), [stats(P2, K2, U2, N2)|T], [stats(P1, K1, U1, N1), stats(P2, K2, U2, N2)|T]) :-
    bandingkan_stats(stats(P1, K1, U1, N1), stats(P2, K2, U2, N2)), !.

% Jika tidak, terus cari posisinya di bagian Tail/Sisanya
insert_stats(X, [H|T], [H|Rest]) :-
    insert_stats(X, T, Rest).

/*Buat nyari poin*/

% Kondisi 1: Poin lebih kecil menempati peringkat lebih tinggi
bandingkan_stats(stats(P1, _, _, _), stats(P2, _, _, _)) :- 
    P1 < P2.

% Kondisi 2: Jika poin sama, jumlah kartu lebih sedikit diutamakan
bandingkan_stats(stats(P, K1, _, _), stats(P, K2, _, _)) :- 
    K1 < K2.

% Kondisi 3: Jika poin dan kartu sama, urutan bermain awal menentukan
bandingkan_stats(stats(P, K, U1, _), stats(P, K, U2, _)) :- 
    U1 < U2.