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

% --- SKENARIO 0: VALIDASI PEMAIN TIDAK DITEMUKAN ---
tangkap(Target) :-
    \+ player(Target, _),
    !,
    format('Sistem: Pemain dengan nama ~w tidak ditemukan!~n', [Target]).
% --- SKENARIO 1: TANGKAPAN BERHASIL (TARGET BERSALAH) ---
tangkap(Target) :-
    currentPlayer(Penuduh),
    player(Target, ListKartuTarget),
    getLength(ListKartuTarget, 1),
    \+ status_uni(Target),
    !,
    format('~w tertangkap basah memiliki 1 kartu tapi tidak menyerukan UNI!~n', [Target]),
    format('Hukuman: ~w ditarik 2 kartu penalti.~n', [Target]),
    tarik_kartu_aman(Target, 2).


% --- SKENARIO 2: TANGKAPAN GAGAL (PENUDUH SALAH TUDUH / FITNAH) 
tangkap(Target) :-
    currentPlayer(Penuduh),
    format('Tangkapan gagal! ~w tidak melanggar aturan (kartu > 1 atau sudah bilang UNI).~n', [Target]),
    format('Hukuman: ~w (sebagai penuduh) ditarik 1 kartu penalti.~n', [Penuduh]),
    tarik_kartu_aman(Penuduh, 1).