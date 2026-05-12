:- include('fact.pl').
:- use_module(library(random)).

ambilKartu :- 
    giliran(Pemain), %
    cek(_WarnaMeja, _JenisKartu),
    Jenis is _JenisKartu,
    cetak(Pemain, Jenis), nl,
    pindah_giliran(NextPlayer1),
    format('Giliran ~w.', [NextPlayer1]), nl.

cetak(Pemain, draw_two) :- 
    getCard(Kartu1),
    format('~w mendapatkan kartu : ~w~n', [Pemain, Kartu1]),
    getCard(Kartu2),
    format('~w mendapatkan kartu : ~w~n', [Pemain, Kartu2]).

cetak(Pemain, draw_four) :-
    getCard(Kartu1),
    format('~w mendapatkan kartu : ~w~n', [Pemain, Kartu1]),
    getCard(Kartu2),
    format('~w mendapatkan kartu : ~w~n', [Pemain, Kartu2]),
    getCard(Kartu3),
    format('~w mendapatkan kartu : ~w~n', [Pemain, Kartu3]),
    getCard(Kartu4),
    format('~w mendapatkan kartu : ~w~n', [Pemain, Kartu4]).

cetak(Pemain, Jenis) :-
    Jenis \= draw_four,
    Jenis \= draw_two,
    getCard(Kartu1),
    format('~w mendapatkan kartu : ~w~n', [Kartu1]).

getCard(Kartu) :-
    findall(kartu(Warna, Jenis), kartu_valid(Warna, Jenis), Deck),
    random_member(Kartu, Deck).