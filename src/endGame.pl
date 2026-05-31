% Fakta untuk perhitungan poin
nilai_kartu(kartu(_, 0), 1).
nilai_kartu(kartu(_, 0), 1).
nilai_kartu(kartu(_, 1), 1).
nilai_kartu(kartu(_, 2), 2).
nilai_kartu(kartu(_, 3), 3).
nilai_kartu(kartu(_, 4), 4).
nilai_kartu(kartu(_, 5), 5).
nilai_kartu(kartu(_, 6), 6).
nilai_kartu(kartu(_, 7), 7).
nilai_kartu(kartu(_, 8), 8).
nilai_kartu(kartu(_, 9), 9).

% Kalo ga integer/angka masuk ke fakta aksi 
nilai_kartu(kartu(_, skip), 10).
nilai_kartu(kartu(_, reverse), 10).
nilai_kartu(kartu(_, draw_two), 10).

nilai_kartu(kartu(_, wild), 20).
nilai_kartu(kartu(_, wild_draw_four), 20).
nilai_kartu(kartu(_, mimic), 20).

:- dynamic(sisaKartuPemain/3). /* Efek dinamis untuk tau siapa yang kalah dengan parameter
                                  sisaKartuPemain(Pemain, ListSisaKartu, UrutanPoin) */

% --------- HELPER HELPER GW BUTUH HELPER NI CO ---------------------

% Helper untuk mencetak urutan poin
cetakUrutanPemain([]).
cetakUrutanPemain([Pemain|T]) :-
    sisaKartuPemain(Pemain, SisaKartu, _),
    cetakKalah(Pemain, SisaKartu),
    cetakUrutanPemain(T).

% Buat ngecetak siapa yang kalah 
cetakKalah(Pemain, []) :- % Basis Rekursif
    format('~w: kartu habis = 0 poin~n', [Pemain]).

cetakKalah(Pemain, SisaKartu):- % Kasus Rekursif
    SisaKartu \= [],
    format('~w: ',[Pemain]),
    cetakSisaKartu(SisaKartu),
    write(' = '), 
    cetakPoin(SisaKartu, PoinPemain),
    format(' = ~w poin ~n', [PoinPemain]).

% Helper buat yang kalah
% Helper cetak sisa kartu pemain kalah
cetakSisaKartu([kartu(Warna, Jenis)]):- % Basis Rekursif kalo sisa 1 kartu
    format('~w-~w',[Warna, Jenis]).

cetakSisaKartu([kartu(Warna, Jenis), H|T]):- % Kasus Rekursif kalo ada banyak sisa kartu
    format('~w-~w + ',[Warna, Jenis]),
    cetakSisaKartu([H|T]).

% Helper cetak total poin pemain kalah
cetakPoin([Kartu], PoinPemain):-    % Basis Rekursif kalo sisa 1 Sisa Kartu
    nilai_kartu(Kartu, PoinPemain),
    format('~w', [PoinPemain]).

cetakPoin([Kartu|SisaKartu], PoinAkhir) :- % Kasus Rekursif kalo semisal ada banyak sisa kartu
    nilai_kartu(Kartu, PoinKartu),
    format('~w + ',[PoinKartu]),
    cetakPoin(SisaKartu, NextPoin),
    PoinAkhir is NextPoin + PoinKartu.

% Helper untuk sorting Pemenang
kumpulkan_stats(stats(TotalPoin, JumlahKartu, UrutanAwal, Nama)) :-
    sisaKartuPemain(Nama, ListKartu, UrutanAwal),
    hitung_poin_saja(ListKartu, TotalPoin),
    getLength(ListKartu, JumlahKartu).

% Hitung poin 
hitung_poin_saja([], 0).
hitung_poin_saja([Kartu|T], TotalPoin) :-
    nilai_kartu(Kartu, Poin),
    hitung_poin_saja(T, PoinTail),
    TotalPoin is Poin + PoinTail.

% Helper cetak peringkat pemenang akhir
cetakUrutanAkhir([], _).
cetakUrutanAkhir([stats(Poin, _, _, Nama)|T], Rank) :-
    format('~w. ~w (~w poin)~n', [Rank, Nama, Poin]),
    NextRank is Rank + 1,
    cetakUrutanAkhir(T, NextRank).

% --------------- HELPER BERES AKHIRNYA ---------------------

endGame:-
    \+ player(_, []),
    write('Permainan belum selesai! Pemain belum menghabiskan kartunya!').

endGame:-
    gameMode(turnamen), !,
    endGameTur.

endGame:-
    endGameKlasik.

endGameTur:-
    write('Permainan selesai! '),
    sisaKartuPemain(Pemenang, [], _), % Orang yang menang yang gapunya sisa kartu atau poin = 0
    format('~w menghabiskan semua kartunya!~n', [Pemenang]), nl,
    write('Berikut perhitungan poin sisa kartu.'), nl,

    myFindall(Pemain, sisaKartuPemain(Pemain, _, _), ListPemain),
    cetakUrutanPemain(ListPemain), nl,

    tim(1, [P1, P2]),
    sisaKartuPemain(P1, KartuP1, _),
    sisaKartuPemain(P2, KartuP2, _),
    hitung_poin_saja(KartuP1, PoinP1),
    hitung_poin_saja(KartuP2, PoinP2),
    TotalPoinTim1 is PoinP1 + PoinP2,

    tim(2, [P3, P4]),
    sisaKartuPemain(P3, KartuP3, _),
    sisaKartuPemain(P4, KartuP4, _),
    hitung_poin_saja(KartuP3, PoinP3),
    hitung_poin_saja(KartuP4, PoinP4),
    TotalPoinTim2 is PoinP3 + PoinP4,

    write('Berikut perhitungan poin untuk masing-masing tim.'), nl,
    format('Tim 1 (~w, ~w) : ~w + ~w = ~w',[P1, P2, PoinP1, PoinP2, TotalPoinTim1]), nl,
    format('Tim 2 (~w, ~w) : ~w + ~w = ~w',[P3, P4, PoinP3, PoinP4, TotalPoinTim2]), nl,

    cetakPemenangTur(TotalPoinTim1, TotalPoinTim2).

cetakPemenangTur(TotalPoinTim1, TotalPoinTim2):-
    TotalPoinTim1 < TotalPoinTim2, !,
    write('Selamat, Tim 1 menjadi pemenang!'), nl, !.

cetakPemenangTur(TotalPoinTim1, TotalPoinTim2):-
    TotalPoinTim1 > TotalPoinTim2, !,
    write('Selamat, Tim 2 menjadi pemenang!'), nl, !.


cetakPemenangTur(TotalPoinTim1, TotalPoinTim2):-
    TotalPoinTim1 =:= TotalPoinTim2, !,
    write('Permainan Berakhir dengan Poin Seimbang!'), nl, !.


endGameKlasik:-
    write('Permainan selesai! '),
    sisaKartuPemain(Pemenang, [], _), % Orang yang menang yang gapunya sisa kartu atau poin = 0
    format('~w menghabiskan semua kartunya!~n', [Pemenang]), nl,
    write('Berikut perhitungan poin sisa kartu.'), nl,

    myFindall(Pemain, sisaKartuPemain(Pemain, _, _), ListPemain),
    cetakUrutanPemain(ListPemain), nl,

    myFindall(stats(TotalPoin, JumlahKartu, UrutanAwal, Nama), 
        kumpulkan_stats(stats(TotalPoin, JumlahKartu, UrutanAwal, Nama)), 
        ListUrutanAcak),

    mySort(ListUrutanAcak, ListUrutanRILCUI),
    write('Urutan pemenang:'), nl,
    cetakUrutanAkhir(ListUrutanRILCUI, 1), nl,
    format('Selamat ~w menjadi pemenang!~n', [Pemenang]).

