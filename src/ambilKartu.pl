:- use_module(library(random)).

ambilKartu :-  
    currentPlayer(Pemain),
    topCard(kartu(WarnaMeja,JenisMeja)),
    incrementGiliran,

    cetak(Pemain, JenisMeja), nl,
    getNextPlayer(NextPlayer1),

    retract(currentPlayer(_)),
    assertz(currentPlayer(NextPlayer1)),
    format('Giliran ~w.', [NextPlayer1]), nl.

cetak(Pemain, wild_draw_four) :- !,
    getCard(Pemain,Warna1, Jenis1),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna1, Jenis1]),
    getCard(Pemain,Warna2, Jenis2),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna2, Jenis2]),
    getCard(Pemain,Warna3, Jenis3),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna3, Jenis3]),
    getCard(Pemain,Warna4, Jenis4),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna4, Jenis4]),
        
    % Status pengubahan kartu jika berhasil tantang
    topCard(kartu(WarnaMeja, _)),
    retract(topCard(_)),
    asserta(topCard(kartu(WarnaMeja, wild))).

cetak(Pemain, JenisMeja) :- 
    JenisMeja \= wild_draw_four, !,
    getCard(Pemain,Warna, Jenis),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna, Jenis]).

getCard(Pemain,Warna,Jenis) :-
    retract(deck([Kartu|SisaDeck])), !,
    kartu(Warna,Jenis) = Kartu,
    assertz(deck(SisaDeck)),

    retract(player(Pemain,TanganLama)),
    myAppend(TanganLama,Kartu,TanganBaru),
    assertz(player(Pemain,TanganBaru)).

getCard(Pemain,Warna,Jenis) :-
    cekDeck([],HasilDeck),
    assertz(deck(HasilDeck)),
    getCard(Pemain,Warna,Jenis).

/* Fitur tambahan : jika kartu deck habis, ambil semua kartu yang telah dibuang,
kocok, simpan lagi di deck */

cekDeck([],DeckBaruAcak) :-
    myFindall(kartu(Warna,Jenis), kartu(Warna,Jenis), DeckBaru),
    randomList(DeckBaru,DeckBaruAcak),

    write('Kartu di deck sudah habis!'), nl,
    write('Kartu telah diambil dari meja dan di-shuffle kembali.'), nl.

cekDeck(Deck,Deck).