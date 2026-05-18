
% SKENARIO 1: TANGKAPAN BERHASIL
tangkap(Target) :-
    currentPlayer(Penuduh),
    player(Target, ListKartuTarget),
    getLength(ListKartuTarget, 1),
    \+ status_uni(Target),
    !,
    getCard(Kartu1),
    getCard(Kartu2),
    myAppend(ListKartuTarget, [Kartu1, Kartu2], ListKartuBaruTarget),
    retract(player(Target, _)),
    asserta(player(Target, ListKartuBaruTarget)),
    format('~w tertangkap basah memiliki 1 kartu tapi tidak menyerukan UNI!~n', [Target]),
    format('Hukuman: ~w ditarik 2 kartu penalti.~n', [Target]).

% SKENARIO 2: TANGKAPAN GAGAL
tangkap(Target) :-
    currentPlayer(Penuduh),
    format('Tangkapan gagal! ~w tidak melanggar aturan (kartu > 1 atau sudah bilang UNI).~n', [Target]),
    format('Hukuman: ~w (sebagai penuduh) ditarik 1 kartu penalti.~n', [Penuduh]),
    
    getCard(KartuHukuman),
    player(Penuduh, ListKartuPenuduh),
    myAppend(ListKartuPenuduh, [KartuHukuman], ListKartuBaruPenuduh),
    
    retract(player(Penuduh, _)),
    asserta(player(Penuduh, ListKartuBaruPenuduh)).
