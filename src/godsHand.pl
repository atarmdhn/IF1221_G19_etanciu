godsHand :-
    \+ satuKartuSemua,
    peluangTerpanggil, !,

    pemainDiambil(Pemilik, Kartu),
    pemainDikasih(Pemilik, Penerima, Kartu),

    getNextPlayer(PemainNext),
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainNext)),
    
    write('Tuhan telah berkehendak.'), nl,
    format('Kartu ~w milik ~w berpindah ke tangan ~w!~n',
        [Kartu, Pemilik, Penerima]),

    format('Giliran ~w~n', [PemainNext]).

    godsHand :-
    getNextPlayer(PemainNext),
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainNext)),
    write('Tuhan tidak berkehendak.'), nl,
    format('Giliran ~w~n', [PemainNext]).

satuKartuSemua :-
    playerOrder(ListPemain),
    cekSatuKartuSemua(ListPemain).
cekSatuKartuSemua([]).
cekSatuKartuSemua([Pemain | Sisa]) :-
    player(Pemain, ListKartu),
    length(ListKartu, 1),
    cekSatuKartuSemua(Sisa).

peluangTerpanggil :-
    random(1, 11, X),
    X =:= 1.

hapusKartu(Kartu, [Kartu|Sisa], Sisa).

hapusKartu(Kartu, [Head|Sisa], [Head|SisaBaru]) :-
    hapusKartu(Kartu, Sisa, SisaBaru).


pemainDiambil(Pemilik, Kartu) :-
    playerOrder(ListPemain),

    length(ListPemain, N),
    random(0, N, IdxPemain), 
    nth0(IdxPemain, ListPemain, Pemilik),

    player(Pemilik, ListKartu),

    length(ListKartu, M),
    random(0, M, IdxKartu),
    nth0(IdxKartu, ListKartu, Kartu),

    hapusKartu(Kartu, ListKartu, SisaKartu),

    retract(player(Pemilik, ListKartu)),
    assertz(player(Pemilik, SisaKartu)).


pemainDikasih(Pemilik, Penerima, Kartu) :-
    findall(Pemain, (player(Pemain,_), Pemain \= Pemilik), Kandidat),

    length(Kandidat, N),
    random(0, N, IdxKandidat), 
    nth0(IdxKandidat, Kandidat, Penerima),

    player(Penerima, ListKartu),

    ListKartuBaru = [Kartu | ListKartu],

    retract(player(Penerima, ListKartu)),
    assertz(player(Penerima, ListKartuBaru)).
