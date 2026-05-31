:- dynamic(status_uni/1). %list pemain dengan status uni
:- dynamic(player/2). % menyimpan tangan player(Nama,ListKartu)
:- dynamic(playerOrder/1). % menyimpan urutan giliran
:- dynamic(currentPlayer/1). % menyimpan pemain yang mendapat giliran
:- dynamic(gameDirection/1). % menyimpan alur permainan (normal/reverse).
:- dynamic(topCard/1). % menyimpan info kartu teratas di meja 
:- dynamic(tempPlayer/1). % menyimpan input nama pemain
:- dynamic(deck/1). % menyimpan list deck kartu
:- dynamic(memoriTantangan/2). % menyimpan kartu pemain sebelumnya kartu tantangan
:- dynamic(gameMode/1). % nyimpan mode game bisa klasik yang semua lawanan ato turnamen 2v2
:- dynamic(tim/2). % nyimpen anggota tim buat mode turnamen
:- dynamic(swapTim/1). % ngecek udh swap blm


loadGame :-
    write('Masukkan nama file yang akan dimuat: '),
    read(NamaFile),
    name(NamaFile, NamaFileASCII),
    name('.txt', NamaExtASCII),
    insert_ASCII(NamaFileASCII, NamaExtASCII, NamaFileSaveASCII),
    name(NamaFileSave, NamaFileSaveASCII),

    emptyGame,

    open(NamaFileSave, read, Stream),
    
    bacaFile(Stream),

    close(Stream),

    write('Status permainan berhasil dimuat.').

loadGame :- 
    write('File tidak ditemukan.'), nl.

emptyGame :-
    retractall(player(_, _)), 
    retractall(playerOrder(_)), 
    retractall(currentPlayer(_)), 
    retractall(topCard(_)), 
    retractall(gameDirection(_)), 
    retractall(status_uni(_)), 
    retractall(memoriTantangan(_, _)),
    retractall(gameMode(_)),
    retractall(tim(_, _)),
    retractall(swapTim(_)).


bacaFile(Stream) :-
    read(Stream, Term),

    (Term == end_of_file
    ->
    true
    ;
    bacaTerm(Term),
    bacaFile(Stream)
    ).

    
unformatKartu([], []).

unformatKartu([Warna-Jenis | Sisa], [kartu(Warna, Jenis) | Hasil]) :-
    unformatKartu(Sisa, Hasil).

unformatKartu(Warna-Jenis, kartu(Warna, Jenis)).


bacaTerm(urutan_pemain:ListPemain) :-
    assertz(playerOrder(ListPemain)).

bacaTerm(giliran:Pemain) :-
    assertz(currentPlayer(Pemain)).

bacaTerm(discard_top:FormatKartu) :-
    unformatKartu(FormatKartu, Kartu),
    assertz(topCard(Kartu)).

bacaTerm(warna_aktif:Warna) :-
    assertz(warnaAktif(Warna)).

bacaTerm(arah_permainan:Arah) :-
    assertz(gameDirection(Arah)).

bacaTerm(status_UNI:StatusUNI) :-
    assertz(status_uni(StatusUNI)).

bacaTerm(kartu(Nama):FormatListKartu) :-
    unformatKartu(FormatListKartu, ListKartu),
    assertz(player(Nama, ListKartu)).

bacaTerm(mode:Mode) :-
    assertz(gameMode(Mode)).

bacaTerm(tim1:Tim1) :-
    assertz(tim(1, Tim1)).

bacaTerm(tim2:Tim2) :-
    assertz(tim(2, Tim2)).

bacaTerm(_) :-
    true.
