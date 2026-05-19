cekInfo :-
    currentPlayer(Pemain),
    topCard(kartu(WarnaMeja, JenisMeja)),
    playerOrder(Urutan),
    gameDirection(ArahMain)
    format('Kartu discard top: ~w-~w~n', [WarnaMeja, JenisMeja]),
    write('Urutan pemain: '), 
    cetakUrutan(Urutan, ArahMain), write('.'), nl, nl,
    cetakInfoPemain(Urutan, 1).

cetakUrutan(Urutan, normal):-
    printList(Urutan).

cetakUrutan(Urutan, reverse):-
    myReverse(Urutan, UrutanBaru),
    printList(UrutanBaru).

cetakInfoPemain([], _).
cetakInfoPemain([Pemain | SisaPemain], IndexPemain):-
    format('Nama pemain ~w: ~w~n', [IndexPemain, Pemain]),
    player(Pemain, ListKartu),
    length(ListKartu, BanyakKartu),
    format('Jumlah kartu: ~w~n~n', [BanyakKartu]),
    NextIndex is IndexPemain + 1,
    cetakInfoPemain(SisaPemain, NextIndex).

myReverse(ListLama, ListBaru):-
    reverseHelper(ListLama, [], ListBaru).

reverseHelper([], ListBaru, ListBaru).
reverseHelper([H|T], ListSementara, ListBaru):-
    reverseHelper(T, [H|ListSementara], ListBaru).