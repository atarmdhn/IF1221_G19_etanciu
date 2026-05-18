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


% SKENARIO 0: KONDISI TIDAK VALID (PENCEGAH ERROR)
tantang :-
    \+ memoriTantangan(_, _),
    !,
    write('Tantangan tidak valid! Tidak ada kartu Wild Draw Four yang baru saja dimainkan.'), nl.

% SKENARIO 1: TANTANGAN BERHASIL (PELAKU KETAHUAN BOHONG)
tantang :-
    currentPlayer(Penantang),
    memoriTantangan(Pelaku, WarnaSebelumnya),
    player(Pelaku, ListKartuPelaku),
    member(kartu(WarnaSebelumnya, _), ListKartuPelaku),
    !,
    format('~w menantang ~w!', [Penantang, Pelaku]), nl,
    write('Tantangan BERHASIL! Pelaku ternyata masih memiliki kartu warna yang cocok di tangannya.'), nl,
    format('Hukuman: ~w (Pelaku) ditarik 4 kartu.~n', [Pelaku]),
    tarik_kartu_aman(Pelaku, 4),
    retractall(memoriTantangan(_, _)),
    prosesEfekdanTurn(gagal).

% SKENARIO 2: TANTANGAN GAGAL (PENANTANG SALAH TUDUH)
tantang :-
    currentPlayer(Penantang),
    memoriTantangan(Pelaku, _),
    format('~w menantang ~w!', [Penantang, Pelaku]), nl,
    write('Tantangan GAGAL! Pelaku jujur, dia memang tidak punya kartu dengan warna tersebut.'), nl,
    format('Hukuman: ~w (Penantang) ditarik 6 kartu (4 kartu asli + 2 denda fitnah).~n', [Penantang]),
    tarik_kartu_aman(Penantang, 6),
    retractall(memoriTantangan(_, _)),
    prosesEfekdanTurn(gagal).