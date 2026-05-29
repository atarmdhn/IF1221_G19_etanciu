lihatCommand :-
    topCard(kartu(_, Jenis)), 
    cetak(Jenis), nl,
    cetakPendukung.

cetak(draw_two) :-
    write('Aksi Utama Yang Tersedia :'), nl,
    write('1. ambilKartu'), nl.

cetak(wild_draw_four) :-
    write('Aksi Utama Yang Tersedia :'), nl,
    write('1. ambilKartu'), nl,
    write('2. tantang'), nl.

cetak(Jenis) :-
    Jenis \= draw_two,
    Jenis \= wild_draw_four, 
    write('Aksi Utama Yang Tersedia :'), nl,
    write('1. ambilKartu'), nl,
    write('2. mainkanKartu'), nl.

cetakPendukung :-
    write('Aksi Pendukung Yang Tersedia :'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'),
    write('4. sembunyikanKartu(NomorUrut)').