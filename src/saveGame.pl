:- dynamic(status_uni/1). %list pemain dengan status uni
:- dynamic(player/2). % menyimpan tangan player(Nama,ListKartu)
:- dynamic(playerOrder/1). % menyimpan urutan giliran
:- dynamic(currentPlayer/1). % menyimpan pemain yang mendapat giliran
:- dynamic(gameDirection/1). % menyimpan alur permainan (normal/reverse).
:- dynamic(topCard/1). % menyimpan info kartu teratas di meja 
:- dynamic(tempPlayer/1). % menyimpan input nama pemain
:- dynamic(deck/1). % menyimpan list deck kartu
:- dynamic(memoriTantangan/2). % menyimpan kartu pemain sebelumnya kartu tantangan
:- dynamic(warnaAktif/1). % menyimpan warna aktif kartu
:- dynamic(gameMode/1). % nyimpan mode game bisa klasik yang semua lawanan ato turnamen 2v2
:- dynamic(tim/2). % nyimpen anggota tim buat mode turnamen
:- dynamic(swapTim/1). % ngecek udh swap blm


insert_ASCII([], ASCII2, ASCII2).
insert_ASCII([ASCII1 | Sisa], ASCII2, [ASCII1 | HasilNama]) :-
    insert_ASCII(Sisa, ASCII2, HasilNama).



saveGame :-
    write('Masukkan nama file penyimpanan: '),
    read(NamaFile),

    name(NamaFile, NamaFileASCII),
    name('.txt', NamaExtASCII),
    insert_ASCII(NamaFileASCII, NamaExtASCII, NamaFileSaveASCII),
    name(NamaFileSave, NamaFileSaveASCII),
    
    open(NamaFileSave, write, Stream),
    cetakSave(Stream),
    
    close(Stream),

    format('Status permainan berhasil disimpan ke ~w.~n', [NamaFileSave]).



cetakSave(Stream) :-
    \+ gameMode(turnamen), !,

    cetakUrutanPemain(Stream),

    cetakCurrentPemain(Stream),

    cetakDiscardTop(Stream),

    cetakWarnaAktif(Stream),

    cetakArahMain(Stream),

    cetakStatusUni(Stream),

    cetakPemainKartu(Stream).

cetakSave(Stream) :-
    gameMode(turnamen), !,

    cetakMode(Stream),

    cetakTim(Stream),

    cetakUrutanPemain(Stream),

    cetakCurrentPemain(Stream),

    cetakDiscardTop(Stream),

    cetakWarnaAktif(Stream),

    cetakArahMain(Stream),

    cetakStatusUni(Stream),

    cetakPemainKartu(Stream).


cetakUrutanPemain(Stream) :-
    playerOrder(ListPemain),
    write_term(Stream, urutan_pemain:ListPemain, [fullstop(true)]), nl(Stream).

cetakCurrentPemain(Stream) :-
    currentPlayer(Pemain),
    write_term(Stream, giliran:Pemain, [fullstop(true)]), nl(Stream).

cetakDiscardTop(Stream) :-
    topCard(DiscardTop),
    formatKartu(DiscardTop, FormatDiscardTop),
    write_term(Stream, discard_top:FormatDiscardTop, [fullstop(true)]), nl(Stream).

cetakWarnaAktif(Stream) :-
    topCard(kartu(Warna, _)),
    write_term(Stream, warna_aktif:Warna, [fullstop(true)]), nl(Stream).


cetakArahMain(Stream) :-
    gameDirection(ArahGame),
    write_term(Stream, arah_permainan:ArahGame, [fullstop(true)]), nl(Stream).


cetakStatusUni(Stream) :-
    status_uni(StatusUNI),
    write_term(Stream, status_UNI:StatusUNI, [fullstop(true)]), nl(Stream).

cetakPemainKartu(Stream) :-
    forall(player(Nama, ListKartu), 
        (formatKartu(ListKartu, FormatListKartu),
        write_term(Stream, kartu(Nama):FormatListKartu, [fullstop(true)]), nl(Stream))).

cetakMode(Stream) :-
    gameMode(Mode),
    write_term(Stream, mode:Mode, [fullstop(true)]), nl(Stream).

cetakTim(Stream) :-
    tim(1, Tim1),
    write_term(Stream, tim1:Tim1, [fullstop(true)]), nl(Stream),

    tim(2, Tim2),
    write_term(Stream, tim2:Tim2, [fullstop(true)]), nl(Stream).

formatKartu([], []).
formatKartu([kartu(Warna,Jenis) | Sisa], [Warna-Jenis | Hasil]) :-
    formatKartu(Sisa, Hasil).
formatKartu(kartu(Warna, Jenis), Warna-Jenis).