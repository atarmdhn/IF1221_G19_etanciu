:- dynamic pemain/1.
:- dynamic discard_top/1.
:- dynamic arah/1.
:- dynamic listKartuSave/2.




loadGame :-
    write('Masukkan nama file yang akan dimuat: '),
    read(NamaFile),
    name(NamaFile, NamaFileASCII),
    name('.txt', NamaExtASCII),
    insert_ASCII(NamaFileASCII, NamaExtASCII, NamaFileSaveASCII),
    name(NamaFileSave, NamaFileSaveASCII),

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


bacaFile(Stream) :-
    read(Stream, Term),

    (Term == end_of_file
    ->
    true
    ;
    bacaTerm(Term),
    bacaFile(Stream).
    )

    
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

bacaTerm(_) :-
    true.
