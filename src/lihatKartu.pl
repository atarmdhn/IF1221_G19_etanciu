lihatKartu :-
    currentPlayer(Pemain),
    player(Pemain, ListKartu),
    write('Berikut kartu yang anda miliki.'), nl,
    cetakList(ListKartu, 1), nl,
    cetakKartuTeman(Pemain).

cetakList([], _).

cetakList([kartu(Warna, Jenis) | Sisa], IndexKartu):-
    format('~w. ~w-~w~n',[IndexKartu, Warna, Jenis]),
    NextIndex is IndexKartu + 1,
    cetakList(Sisa, NextIndex).

cetakKartuTeman(Pemain) :-
    gameMode(turnamen), !,
    cariTemanTim(Pemain, Teman),
    player(Teman, ListKartuTeman),
    format('Kartu ~w (Teman Tim):~n', [Teman]),
    cetakList(ListKartuTeman, 1), nl.

cetakKartuTeman(_) :- !.