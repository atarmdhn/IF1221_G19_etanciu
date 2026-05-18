cekInfo :-
    currentPlayer(Pemain),
    format('Kartu discard top: ~w-~w~n', [WarnaMeja, Jenis]),
    format('Urutan pemain: '), printList(Urutan), nl,
    cetakInfoPemain(Pemain, 1).

cetakInfoPemain([], _).
cetakInfoPemain([Pemain | SisaPemain], IndexPemain):-
    format('Nama pemain ~w: ~w~n', [IndexPemain, Pemain]),
    kartuPemain(Pemain, ListKartu),
    length(ListKartu, BanyakKartu),
    format('Jumlah kartu: ~w', BanyakKartu),
    NextIndex is IndexPemain + 1,
    cetakInfoPemain(SisaPemain, NextIndex).

