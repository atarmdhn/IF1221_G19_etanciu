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
    write('2. mainkanKartu(NomorUrut)'), nl.

cetakPendukung :- 
    gameMode(turnamen), !,
    write('Aksi Pendukung Yang Tersedia :'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'), nl,
    write('4. sembunyikanKartu(NomorUrut)'), nl,
    write('5. swapKartu(NomorUrut, NomorUrutTeman)').

cetakPendukung :-
    write('Aksi Pendukung Yang Tersedia :'), nl,
    write('1. lihatCommand'), nl,
    write('2. lihatKartu'), nl,
    write('3. cekInfo'), nl,
    write('4. sembunyikanKartu(NomorUrut)').