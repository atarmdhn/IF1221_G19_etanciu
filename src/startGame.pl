startGame :-
    retractall(player(_,_)),
    retractall(playerOrder(_)),
    retractall(currentPlayer(_)),
    retractall(gameDirection(_)),
    retractall(topCard(_)),
    retractall(tempPlayer(_)),
    retractall(status_uni(_)),
    retractall(kartu_tersembunyi(_,_)),
    retractall(memoriTantangan(_,_)),
    retractall(warnaAktif(_)),
    retractall(gameMode(_)),
    retractall(tim(_,_)),
    retractall(swapTim(_)),
    assertz(status_uni([])),

    nl,
    write('Tersedia 2 mode permainan.'), nl,
    write('1. Mode klasik'), nl,
    write('2. Mode turnamen'), nl,
    write('Pilih mode permainan: '),
    read(Mode), nl,

    setupMode(Mode).


setupMode(1):-
    assertz(gameMode(klasik)),
    askPlayerCount(Count),
    askPlayerNames(1, Count),
    getAllPlayers(Players),
    randomList(Players,RandomPlayers),
    setupLanjutan(RandomPlayers).

setupMode(2):-
    assertz(gameMode(turnamen)),
    write('Permainan dimulai dalam mode turnamen'), nl, nl,
    askPlayerNames(1, 4),
    getAllPlayers(Players),
    write('Membentuk tim secara acak...'), nl, nl,
    randomList(Players, PlayersAcak),
    bentukTim(PlayersAcak, UrutanTur),
    setupLanjutan(UrutanTur).

setupMode(_):-
    write('Pilihan tidak valid. Silakan masukkan angka 1 atau 2.'), nl,
    write('Pilih mode permainan: '),
    read(NewMode), nl,
    setupMode(NewMode).

setupLanjutan(UrutanMain):-
    write('Urutan pemain: '), printList(UrutanMain), nl,
    assertz(playerOrder(UrutanMain)),

    [First|_] = UrutanMain,
    assertz(currentPlayer(First)),
    assertz(gameDirection(normal)),
    write('Setiap pemain mendapatkan 7 kartu acak.'), nl,

    myFindall(kartu(Warna,Jenis), kartu(Warna,Jenis), ListKartu),
    randomList(ListKartu,DeckAcak),
    bagiKartu(UrutanMain,DeckAcak,SisaDeckSetelahDibagi),
    getTopCard(SisaDeckSetelahDibagi,TopCard,FinalDeck),
    assertz(deck(FinalDeck)),
    assertz(topCard(TopCard)),
    TopCard = kartu(Warna,_),
    assertz(warnaAktif(Warna)),

    kartu(Warna,Jenis) = TopCard,
    format('Kartu discard top: ~w - ~w', [Warna,Jenis]), nl, 
    format('Giliran ~w.', [First]), nl.

/* Meminta input jumlah pemain */
askPlayerCount(Count) :-
    write('Masukkan jumlah pemain: '),
    read(In),
    integer(In),
    In >= 2,
    In =< 4, 
    Count = In, !.

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
    \+ tempPlayer(Name),
    assertz(tempPlayer(Name)),
    Next is Count + 1,
    askPlayerNames(Next, Total).

nameInputProcess(Count, Total, Name) :-
    tempPlayer(Name),
    write('Nama sudah digunakan. Masukkan nama lain: '),
    read(NewName),
    nameInputProcess(Count, Total, NewName).

/* Memasukkan semua pemain ke list Players */
getAllPlayers(Players) :-
    myFindall(P, tempPlayer(P), Players).

/* Print pemain di dalam list Players */
printList([H]) :- 
    write(H), !.

printList([H|T]) :-
    write(H),
    write(' - '),
    printList(T).

/* Validasi top card valid (bukan utiity card)*/

getTopCard([CurrentCard|SisaDeck],TopCard,FinalDeck) :-
    CurrentCard = kartu(_,Jenis),
    \+ number(Jenis),!,
    myAppend(SisaDeck,CurrentCard,DeckBaru),
    getTopCard(DeckBaru,TopCard,FinalDeck).

getTopCard([CurrentCard|SisaDeck],CurrentCard,SisaDeck) :- !.

/* Bagi kartu ke pemain */
ambil7([A,B,C,D,E,F,G|SisaDeck],[A,B,C,D,E,F,G], SisaDeck).

bagiKartu([], Deck, Deck).
bagiKartu([Nama|SisaNama], DeckAwal, DeckAkhir) :-
    ambil7(DeckAwal, Kartu, SisaDeck),
    assertz(player(Nama,Kartu)),
    bagiKartu(SisaNama,SisaDeck,DeckAkhir).
/* Hasil : player(ata,[kartu(kuning,skip),kartu(biru,5),...)]), 
        player(kuri,[kartu(merah,4),...]),
        ... */

/* Bentuk Tim buat mode Turnamen*/
bentukTim([P1, P2, P3, P4], [P1, P3, P2, P4]):-
    assertz(tim(1, [P1, P2])),
    assertz(tim(2, [P3, P4])),
    format('Tim 1 : ~w dan ~w~n',[P1, P2]),
    format('Tim 2 : ~w dan ~w~n~n',[P3, P4]).
