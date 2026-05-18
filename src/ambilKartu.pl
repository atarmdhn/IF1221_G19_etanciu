:- use_module(library(random)).

ambilKartu :-  
    currentPlayer(Pemain),
    topCard(kartu(WarnaMeja,JenisMeja)),
    cetak(Pemain, JenisMeja), nl,
    getNextPlayer(NextPlayer1),

    retract(currentPlayer(_)),
    assertz(currentPlayer(NextPlayer1)),
    format('Giliran ~w.', [NextPlayer1]), nl.

cetak(Pemain, draw_four) :- !,
    getCard(Pemain,Warna1, Jenis1),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna1, Jenis1]),
    getCard(Pemain,Warna2, Jenis2),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna2, Jenis2]),
    getCard(Pemain,Warna3, Jenis3),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna3, Jenis3]),
    getCard(Pemain,Warna4, Jenis4),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna4, Jenis4]).

cetak(Pemain, JenisMeja) :- 
    JenisMeja \= draw_four, !,
    getCard(Pemain,Warna, Jenis),
    format('~w mendapatkan kartu : ~w - ~w~n', [Pemain, Warna, Jenis]).

getCard(Pemain,Warna,Jenis) :-
    retract(deck(KartuDeck)),
    [Kartu|SisaDeck] = KartuDeck,
    kartu(Warna,Jenis) = Kartu,
    assertz(deck(SisaDeck)),

    retract(player(Pemain,TanganLama)),
    myAppend(TanganLama,Kartu,TanganBaru),
    assertz(player(Pemain,TanganBaru)).
