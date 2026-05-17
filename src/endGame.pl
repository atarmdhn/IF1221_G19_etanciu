:- include('startGame.pl').
:- include('importantFunctions.pl').
:- include('fact.pl').

% Fakta untuk perhitungan poin
nilai_kartu(kartu(_, Jenis), Nilai) :- % Berlaku untuk jenis angka 0 - 9
    integer(Jenis),
    Nilai = Jenis.

% Kalo ga integer/angka masuk ke fakta aksi 
nilai_kartu(kartu(_, skip), 10).
nilai_kartu(kartu(_, reverse), 10).
nilai_kartu(kartu(_, draw_two), 10).

nilai_kartu(kartu(_, wild), 20).
nilai_kartu(kartu(_, draw_four), 20).
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
    format(' = ~w poin', [PoinPemain]).

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
    write('Permainan selesai! '),
    sisaKartuPemain(Pemenang, [], _), % Orang yang menang yang gapunya sisa kartu atau poin = 0
    format('~w menghabiskan semua kartunya!~n', [Pemenang]), nl,
    format('Berikut perhitungan poin sisa kartu.~n'),

    myFindall(Pemain, sisaKartuPemain(Pemain, _, _), ListPemain),
    cetakUrutanPemain(ListPemain), nl,

    myFindall(stats(TotalPoin, JumlahKartu, UrutanAwal, Nama), 
        kumpulkan_stats(stats(TotalPoin, JumlahKartu, UrutanAwal, Nama)), 
        ListUrutanAcak),

    mySort(ListUrutanAcak, ListUrutanRILCUI),
    format('Urutan Pemenang:~n'),
    cetakUrutanAkhir(ListUrutanRILCUI, 1), nl,
    format('Selamat ~w menjadi pemenang!~n', [Pemenang]).






