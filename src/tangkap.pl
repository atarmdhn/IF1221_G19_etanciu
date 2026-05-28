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

% VALIDASI PEMAIN TIDAK DITEMUKAN 
tangkap(Target) :-
    \+ player(Target, _),
    !,
    format('Pemain dengan nama ~w tidak ditemukan!~n', [Target]).
    
% TANGKAPAN BERHASIL
tangkap(Target) :-
    currentPlayer(Penuduh),
    player(Target, ListKartuTarget),
    getLength(ListKartuTarget, JumlahTerlihat),
    myFindall(Kartu, kartu_tersembunyi(Target, Kartu), ListTersembunyi),
    getLength(ListTersembunyi, JumlahTersembunyi),
    TotalKartu is JumlahTerlihat + JumlahTersembunyi,
    TotalKartu =:= 1,
    \+ status_uni(Target),
    !,
    format('~w tertangkap basah memiliki 1 kartu tapi tidak menyerukan UNI!~n', [Target]),
    format('Hukuman: ~w ditarik 2 kartu penalti.~n', [Target]),
    tarik_kartu_aman(Target, 2).
    
% TANGKAPAN GAGAL 
    tangkap(Target) :-
        currentPlayer(Penuduh),
        format('Yahh fitnah luu, ~w soalnya tidak melanggar aturan (Total kartu > 1 atau sudah bilang UNI).~n', [Target]),
        format('Lu dihukum, ambil 1 kartu penalti.~n', [Penuduh]),
        tarik_kartu_aman(Penuduh, 1).
