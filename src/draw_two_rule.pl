% rule drawTwo
drawTwo(kartu(Warna, draw_two)) :- 
    giliran(Pemain),

    retract(kartu(_WarnaMeja, _)),            % Ngubah top_pile sebelumnya jadi kartu draw_two yang dimainkan
    asserta(kartu(Warna, draw_two)),

    pindah_giliran(NextPlayer), % ubah giliran

    tambah_kartu(NextPlayer, ambilKartu(Kartu1)), %NextPlayer ngambil 2 kartu acak
    tambah_kartu(NextPlayer, ambilKartu(Kartu2)).



