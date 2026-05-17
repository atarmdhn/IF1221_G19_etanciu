% menarik N kartu
tarikNKartu(0, _) :- !.
tarikNKartu(N, Pemain) :-
    N > 0,
    getCard(KartuBaru),
    player(Pemain, ListLama),
    append(ListLama, [KartuBaru], ListBaru),
    retract(player(Pemain, _)),
    asserta(player(Pemain, ListBaru)),
    N1 is N - 1,
    tarikNKartu(N1, Pemain).

tantang :-
    \+ topCard(kartu(hitam, drawFour)), 
    !,
    write('Gagal! Kartu terakhir di meja bukan Wild Draw Four (+4). Anda tidak bisa menantang.'), nl.

% SKENARIO 1: Tantangan berhasil
tantang :-
    topCard(kartu(hitam, drawFour)),
    currentPlayer(Penantang),
    memoriTantangan(Pelaku, WarnaSebelumnya),
    player(Pelaku, ListKartuPelaku),
    member(kartu(WarnaSebelumnya, _), ListKartuPelaku),
    !,
    format('~w menantang ~w!', [Penantang, Pelaku]), nl,
    write('Tantangan BERHASIL! Pelaku ternyata memiliki kartu warna yang cocok di tangannya.'), nl,
    format('Hukuman: ~w ditarik 4 kartu.~n', [Pelaku]),
    tarikNKartu(4, Pelaku),
    retractall(memoriTantangan(_, _)),
    prosesEfekdanTurn(gagal).

%SKENARIO 2: Tantangan gagal
tantang :-
    topCard(kartu(hitam, drawFour)),
    currentPlayer(Penantang),
    memoriTantangan(Pelaku, _WarnaSebelumnya),
    format('~w menantang ~w!', [Penantang, Pelaku]), nl,
    write('Tantangan GAGAL! Pelaku jujur, dia memang tidak punya kartu dengan warna yang cocok.'), nl,
    format('Hukuman: ~w ditarik 6 kartu (4 kartu asli + 2 denda fitnah).~n', [Penantang]),
    tarikNKartu(6, Penantang),
    retractall(memoriTantangan(_, _)),
    prosesEfekdanTurn(gagal).