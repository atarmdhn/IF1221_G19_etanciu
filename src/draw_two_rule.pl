% cek apakah sebelumnya draw_two atau bukan
cekValid(Warna, draw_two) :- 
    top_pile(WarnaBef, NilaiBef), 
    NilaiBef \= draw_two,
    Warna == WarnaBef

% rule drawTwo
drawTwo(kartu(Warna, draw_two)) :- 
    cekValid(Warna, draw_two),
    giliran(Pemain),

    retract(top_pile(_, _)),            % Ngubbah top_pile sebelumnya jadi kartu draw_two yang dimainkan
    asserta(top_pile(Warna, draw_two)),

    pindah_giliran(NextPlayer), % ubah giliran

    tambah_kartu(NextPlayer, ambilKartu(Kartu1)), %NextPlayer ngambil 2 kartu acak
    tambah_kartu(NextPlayer, ambilKartu(Kartu2)).



