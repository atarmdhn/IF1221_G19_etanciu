generate_n_cards(0, []) :- !.
generate_n_cards(N, [Kartu | Rest]) :-
    N > 0,
    myFindall(kartu(W, J), kartu(W, J), SemuaKartu),
    getOneRandom(SemuaKartu, Kartu),
    N1 is N - 1,
    generate_n_cards(N1, Rest).

gabung_list([], L, L) :- !.
gabung_list([H|T], L, [H|Rest]) :- gabung_list(T, L, Rest).

tarik_kartu_aman(Target, N) :-
    generate_n_cards(N, ListHukuman),
    player(Target, ListLama),
    gabung_list(ListLama, ListHukuman, ListBaru),
    retract(player(Target, _)),
    asserta(player(Target, ListBaru)),
    !.
% SKENARIO 1: TANTANGAN BERHASIL (PELAKU KETAHUAN BOHONG)
tantang :-
    currentPlayer(Penantang),
    memoriTantangan(Pelaku, WarnaSebelumnya),
    player(Pelaku, ListKartuPelaku),
    member(kartu(WarnaSebelumnya, _), ListKartuPelaku),
    !,
    
    format('~w menantang ~w!', [Penantang, Pelaku]), nl,
    write('Tantangan BERHASIL! Pelaku (yang melempar +4) ketahuan berbohong.'), nl,
    format('Hukuman: ~w ditarik 4 kartu.~n', [Pelaku]),
    

    tarik_kartu_aman(Pelaku, 4),
    topCard(kartu(WarnaMeja, _)),
    retract(topCard(_)),
    asserta(topCard(kartu(WarnaMeja, wild))),
    retractall(memoriTantangan(_, _)),

    format('Giliran tetap di ~w! Anda lolos dari hukuman, silakan mainkanKartu atau ambilKartu.~n', [Penantang]),
    !. 

% SKENARIO 2: TANTANGAN GAGAL (PENANTANG SALAH TUDUH)
tantang :-
    currentPlayer(Penantang),
    memoriTantangan(Pelaku, _),
    format('~w menantang ~w!', [Penantang, Pelaku]), nl,
    write('Tantangan GAGAL! Pelaku jujur, dia memang tidak punya kartu dengan warna tersebut.'), nl,
    format('Hukuman: ~w (Penantang) ditarik 6 kartu (4 kartu asli + 2 denda fitnah).~n', [Penantang]),
    tarik_kartu_aman(Penantang, 6),
    topCard(kartu(WarnaMeja, _)),
    retract(topCard(_)),
    asserta(topCard(kartu(WarnaMeja, wild))),
    retractall(memoriTantangan(_, _)),
    prosesEfekdanTurn(gagal),
    !.