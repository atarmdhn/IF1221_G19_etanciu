mainkanKartu(NomorUrut) :-
    currentPlayer(PemainAktif),
    topCard(CurrentTop),

    retract(player(PemainAktif,TanganLama)),
    Indeks is NomorUrut - 1,
    eksekusiKartu(PemainAktif, TanganLama, Indeks, CurrentTop).

/* Kondisi 1 : Nomor urut tidak valid */
eksekusiKartu(PemainAktif, TanganLama, Indeks, _) :-
    \+ getAndRemove(Indeks,TanganLama,_,_), !,
    assertz(player(PemainAktif,TanganLama)),
    write('Nomor urut invalid!'), fail.

/* Kondisi 2 : Kartu yang dipilih tidak sesuai dengan kartu meja */
eksekusiKartu(PemainAktif,TanganLama,Indeks,CurrentTop) :-
    getAndRemove(Indeks,TanganLama,KartuPilihan,_),
    \+ isKartuValid(KartuPilihan,CurrentTop), !,
    assertz(player(PemainAktif,TanganLama)),
    write('Kartu tidak sesuai dengan kartu di meja!'), fail.

/* Kondisi 3 : Kartu yang dipilih valid */
eksekusiKartu(PemainAktif, TanganLama, Indeks, CurrentTop) :-
    getAndRemove(Indeks, TanganLama, KartuPilihan, TanganBaru),
    isKartuValid(KartuPilihan,CurrentTop), !,
    simpanMemoriTantangan(PemainAktif, CurrentTop, KartuPilihan),
    retract(topCard(CurrentTop)),
    assertz(topCard(KartuPilihan)),
    assertz(player(PemainAktif,TanganBaru)),
    kartu(Warna,Jenis) = KartuPilihan,
    format('~w memainkan kartu : ~w - ~w', [PemainAktif,Warna,Jenis]), nl,
    cekKondisiTangan(TanganBaru, KartuPilihan, PemainAktif).


/* Memeriksa apakah kartu valid */
isKartuValid(kartu(W,_),kartu(W,_)) :- !.
isKartuValid(kartu(_,J),kartu(_,J)) :- !.
isKartuValid(kartu(hitam,_),_) :-!.

/* Proses efek dan turn */

/* Kasus Kartu Abis */
cekKondisiTangan([], _, PemainAktif):- !,
    endGame.

cekKondisiTangan(_, KartuPilihan, _):- 
    prosesEfekdanTurn(KartuPilihan).


/* Wild Draw Four (+4) */
prosesEfekdanTurn(kartu(_,wild_draw_four)) :- !, % Tambahan Cut
    write('Kartu +4 dimainkan! Ketik warna baru (merah./kuning./hijau./biru.): '),
    read(WarnaBaru),
    retract(topCard(_)),
    asserta(topCard(kartu(WarnaBaru, wild_draw_four))),
    format('Warna meja diubah menjadi ~w!~n', [WarnaBaru]),
        
    getNextPlayer(PemainNext),
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainNext)),
    format('Giliran ~w (Ketik tantang. atau ambilKartu.)~n', [PemainNext]).
    
/* wild (Biasa) */
prosesEfekdanTurn(kartu(_,wild)) :- !, % Tambahan Cut
    write('Kartu Wild dimainkan! Ketik warna baru (merah./kuning./hijau./biru.): '),
    read(WarnaBaru),
    retract(topCard(_)),
    asserta(topCard(kartu(WarnaBaru, wild))),
    format('Warna meja diubah menjadi ~w!~n', [WarnaBaru]),
        
    getNextPlayer(PemainNext),
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainNext)),
    format('Giliran ~w~n', [PemainNext]).
    
/* Skip */
prosesEfekdanTurn(kartu(_,skip)) :- !,
    getNextPlayer(PemainNext),
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainNext)),
    getNextPlayer(PemainSetelahnya),
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainSetelahnya)),
    format('Giliran ~w~n', [PemainSetelahnya]).
    
/* Reverse */
prosesEfekdanTurn(kartu(_,reverse)) :- !,
    ubahArahPermainan,
    getNextPlayer(PemainNext),
    retract(currentPlayer(_)), assertz(currentPlayer(PemainNext)),
    format('Giliran ~w~n', [PemainNext]).
    
    /* 5. Draw two (+2) */
    prosesEfekdanTurn(kartu(_,draw_two)) :- !,
    getNextPlayer(PemainNext),
    getCard(PemainNext,Warna1,Jenis1),
    format('~w mendapatkan kartu : ~w - ~w~n', [PemainNext,Warna1,Jenis1]),
    getCard(PemainNext,Warna2,Jenis2),
    format('~w mendapatkan kartu : ~w - ~w~n', [PemainNext,Warna2,Jenis2]),
    format('~w terkena efek skip!~n', [PemainNext]),
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainNext)),
    getNextPlayer(PemainSetelahnya),
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainSetelahnya)),
    format('Giliran ~w~n', [PemainSetelahnya]).
    
    /* 6. handler gagal untuk uni dan tangkap */
prosesEfekdanTurn(gagal) :- !,
    getNextPlayer(PemainNext),
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainNext)),
    format('Giliran ~w~n', [PemainNext]).
    
/* Normal turn */
prosesEfekdanTurn(kartu(_, _)) :- !,
    getNextPlayer(PemainNext), 
    retract(currentPlayer(_)),
    assertz(currentPlayer(PemainNext)),
    format('Giliran ~w~n', [PemainNext]).

simpanMemoriTantangan(Pelaku, kartu(WarnaLama, _), kartu(hitam, wild_draw_four)) :-
    retractall(memoriTantangan(_, _)),            
    asserta(memoriTantangan(Pelaku, WarnaLama)), 
    !.                                        
    
simpanMemoriTantangan(_, _, _) :-
        retractall(memoriTantangan(_, _)).