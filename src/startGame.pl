:- dynamic(player/1).
:- include('importantFunctions.pl').
:- include('fact.pl').

startGame :-
    retractall(player(_)),
    askPlayerCount(Count),
    askPlayerNames(1, Count),
    getAllPlayers(Players),
    randomList(Players,RandomPlayers),
    write('Urutan pemain: '), printList(RandomPlayers), nl,
    write('Setiap pemain mendapatkan 7 kartu acak.'), nl,

    myFindall(kartu(Warna,Jenis), kartu(Warna,Jenis), ListKartu),
    randomList(ListKartu,DeckAcak),
    bagiKartu(RandomPlayers,DeckAcak,ListPemainDanKartu,SisaDeckSetelahDibagi),
    getTopCard(SisaDeckSetelahDibagi,TopCard,FinalDeck),
    kartu(Warna,Jenis) = TopCard,
    format('Kartu discard top: ~w - ~w', [Warna,Jenis]), nl, 
    
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

/* Print pemain di dalam list Players */
printList([H]) :- 
    write(H), !.

printList([H|T]) :-
    write(H),
    write(' - '),
    printList(T).

/* Validasi top card valid (bukan utiity card)*/

getTopCard([CurrentCard|SisaDeck],TopCard,FinalDeck) :-
    CurrentCard = kartu(Warna,Jenis),
    \+ number(Jenis),!,
    myAppend(SisaDeck,CurrentCard,DeckBaru),
    getTopCard(DeckBaru,TopCard,FinalDeck).

getTopCard([CurrentCard|SisaDeck],CurrentCard,SisaDeck) :- !.

/* Bagi kartu ke pemain */
ambil7([A,B,C,D,E,F,G|SisaDeck],[A,B,C,D,E,F,G], SisaDeck).

bagiKartu([], Deck, [], Deck).
bagiKartu([Nama|SisaNama], DeckAwal, [player(Nama,Kartu)|SisaPlayer], DeckAkhir) :-
    ambil7(DeckAwal, Kartu, SisaDeck),
    bagiKartu(SisaNama,SisaDeck,SisaPlayer,DeckAkhir).
/* Hasil : [player(ata,[kartu(kuning,skip),kartu(biru,5),...)]), 
            player(kuri,[kartu(merah,4),...]),
            ...] */