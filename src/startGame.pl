:- dynamic(player/1)
:- use_module(library(random)).

startGame :-
    retractall(player(_)),
    askPlayerCount(Count),
    askPlayerNames(1, Count),
    getAllPlayers(Players),
    randomList(Players,RandomPlayers),
    write('Urutan pemain: '), printList(RandomPlayers), nl,
    write('Setiap pemain mendapatkan 7 kartu acak.'), nl,
    write('Kartu discard top: '), /* belum buat discard kartu */
    [First|_] = RandomPlayers,
    format('Giliran ~w.', [First]), nl.

/* Meminta input jumlah pemain */
askPlayerCount(Count) :-
    write('Masukkan jumlah pemain: '),
    read(In),
    integer(In),
    In >= 2,
    In =< 4, 
    Count = In.

askPlayerCount(Count) :-
    write('Mohon masukkan angka antara 2 - 4.'), nl,
    askPlayerCount(Count).

askPlayerNames(Count, Total) :- 
    Count > Total, !.

/* Meminta input nama pemain */
askPlayerNames(Count, Total) :-
    format('Masukkan nama pemain ~w: ', [Count]),
    read(Name),
    nameInputProcess(Count, Total, Name).

nameInputProcess(Count, Total, Name) :-
    \+ player(Name),
    assertz(player(Name)),
    Next is Count + 1,
    askPlayerNames(Next, Total).

nameInputProcess(Count, Total, Name) :-
    player(Name),
    write('Nama sudah digunakan. Masukkan nama lain: '),
    read(NewName),
    nameInputProcess(Count, Total, NewName).

/* Memasukkan semua pemain ke list Players */
getAllPlayers(Players) :-
    findall(P, player(P), Players).

/* Random list Players */ 
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

/* Print pemain di dalam list Players */
printList([H]) :- 
    write(H), !.

printList([H|T]) :-
    write(H),
    write(' - '),
    printList(T).