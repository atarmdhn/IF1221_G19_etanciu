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
    updateLastActionCard(KartuPilihan, PemainAktif),
    cekKondisiTangan(TanganBaru, KartuPilihan, PemainAktif).

/* Update lastActionCard untuk mimic */

/* Kartu aksi */
updateLastActionCard(Kartu, Pemain) :-
    kartu(_,Jenis) = Kartu,
    \+ number(Jenis),
    Jenis \= mimic, !,
    retractall(lastActionCard(_,_,_)),
    assertz(lastActionCard(Kartu,Pemain,0)).

/* Kartu angka */
updateLastActionCard(Kartu,Pemain) :- 
    kartu(_,Jenis) = Kartu,
    number(Jenis), 
    incrementGiliran.

/* Kartu mimic */
updateLastActionCard(_,_).

incrementGiliran :-
    retract(lastActionCard(KartuAksi,PemainAksi,Waktu)),
    WaktuBaru is Waktu + 1,
    assertz(lastActionCard(KartuAksi,PemainAksi,WaktuBaru)).

incrementGiliran.

/* Memeriksa apakah kartu valid */
isKartuValid(kartu(W,_),kartu(W,_)) :- !.
isKartuValid(kartu(_,J),kartu(_,J)) :- !.
isKartuValid(kartu(hitam,_),_) :-!.

/* Proses efek dan turn */

/* Kasus Kartu Abis */
cekKondisiTangan([], _, PemainAktif):- !,
    sinkronisasiMemoriPemain,
    endGame.

cekKondisiTangan(_, KartuPilihan, _):- 
    sinkronisasiMemoriPemain,
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
    format('Pemain ~w terkena skip!', [PemainNext]), nl,

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
    
/*  Draw two */
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

/* Mimic */
prosesEfekdanTurn(kartu(_,mimic)) :- 
    lastActionCard(KartuAksi, Pemain, Waktu), !,
    write('Menelusuri riwayat permainan.'), nl,
    kartu(Warna,Jenis) = KartuAksi,
    Jenis \= mimic,
    format('Kartu aksi terakhir yang dimainkan: ~w - ~w (oleh ~w, ~w giliran lalu)~n', [Warna,Jenis,Pemain,Waktu]),
    format('Kartu mimic menyalin efek ~w~n',[Jenis]),

    write('Pilih warna (merah/kuning/hijau/biru) : '),
    read(WarnaBaru),
    retract(topCard(_)),
    assertz(topCard(kartu(WarnaBaru,mimic))),
    format('Warna aktif sekarang : ~w~n', [WarnaBaru]),
    prosesEfekdanTurn(KartuAksi).

prosesEfekdanTurn(kartu(_,mimic)) :-
    write('Menelusuri riwayat permainan.'), nl,
    write('Tidak ada kartu aksi yang dimainkan sebelumnya.'), nl,
    write('Kartu mimic menyalin efek wild!'), nl,
    prosesEfekdanTurn(kartu(hitam,wild)), !.

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

/* Memindahkan data player/2 ke sisaKartuPemain/3 untuk dibaca endGame */
sinkronisasiMemoriPemain :-
    retractall(sisaKartuPemain(_,_,_)), % Bersihkan sisa data game sebelumnya
    playerOrder(Urutan),                % Ambil urutan pemain asli
    salinKeSisaKartu(Urutan, 1).

salinKeSisaKartu([], _).
salinKeSisaKartu([Nama | SisaPemain], Index) :-
    player(Nama, ListKartu),
    assertz(sisaKartuPemain(Nama, ListKartu, Index)), % Simpan ke memori yang dibaca endGame
    NextIndex is Index + 1,
    salinKeSisaKartu(SisaPemain, NextIndex).