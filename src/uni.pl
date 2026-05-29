tarik_kartu_aman(_, 0) :- !.
tarik_kartu_aman(Target, N) :-
    N > 0,
    myFindall(kartu(W, J), kartu(W, J), SemuaKartu),
    getOneRandom(SemuaKartu, KartuHukuman),
    player(Target, ListLama),
    myAppend(ListLama, KartuHukuman, ListBaru),
    retract(player(Target, _)),
    asserta(player(Target, ListBaru)),
    N1 is N - 1,
    tarik_kartu_aman(Target, N1).

% SKENARIO 1: SERUAN UNI BERHASIL (KONDISI VALID)
uni(NomorUrut) :-
    currentPlayer(Pemain),
    player(Pemain, ListKartu),
    getLength(ListKartu, 2),
    Indeks is NomorUrut - 1,
    getAndRemove(Indeks, ListKartu, KartuPilihan, ListKartuBaru),
    topCard(KartuMeja),
    isKartuValid(KartuPilihan, KartuMeja),
    !,
    retract(topCard(_)),
    asserta(topCard(KartuPilihan)),
    retract(player(Pemain, _)),
    asserta(player(Pemain, ListKartuBaru)),
    retractall(status_uni(Pemain)),
    asserta(status_uni(Pemain)),
    kartu(Warna, Jenis) = KartuPilihan,
    format('~w memainkan kartu : ~w - ~w~n', [Pemain, Warna, Jenis]),
    format('~w menyerukan UNI!~n', [Pemain]),
    prosesEfekdanTurn(KartuPilihan).

% SKENARIO 2: SERUAN UNI GAGAL (KONDISI INVALID / PENALTI)
uni(_) :-
    currentPlayer(Pemain),
    write('Perintah tidak valid (kartu tidak cocok / jumlah kartu tidak tepat).'), nl,
    write('Penalti: Anda mendapatkan 1 kartu acak.'), nl,
    tarik_kartu_aman(Pemain, 1),
    prosesEfekdanTurn(gagal).