cekInfo :-
    currentPlayer(Pemain),
    topCard(kartu(WarnaMeja, JenisMeja)),
    playerOrder(Urutan),
    format('Kartu discard top: ~w-~w~n', [WarnaMeja, JenisMeja]),
    write('Urutan pemain: '), printList(Urutan), write('.'), nl, nl,
    cetakInfoPemain(Urutan, 1).

cetakInfoPemain([], _).
cetakInfoPemain([Pemain | SisaPemain], IndexPemain):-
    format('Nama pemain ~w: ~w~n', [IndexPemain, Pemain]),
    player(Pemain, ListKartu),
    length(ListKartu, BanyakKartu),
    format('Jumlah kartu: ~w~n~n', [BanyakKartu]),
    NextIndex is IndexPemain + 1,
    cetakInfoPemain(SisaPemain, NextIndex).

