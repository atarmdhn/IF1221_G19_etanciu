lihatKartu :-
    currentPlayer(Pemain),
    listKartu(Pemain, ListKartu),
    write('Berikut kartu yang anda miliki.'), nl,
    cetakList(ListKartu, 1).

cetakList([], _).

cetakList([kartu(Warna, Jenis) | Sisa], IndexKartu):-
    format('~w. ~w-~w~n',[IndexKartu, Warna, Jenis]),
    NextIndex is IndexKartu + 1,
    cetakList(Sisa, NextIndex).