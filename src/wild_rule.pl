wildRule(kartu(hitam,wild), WarnaBaru) :-

    warna(WarnaBaru),
    retract(top_pile(kartu(_, _))),
    asserta(top_pile(kartu(WarnaBaru, _))).

wildDrawFour(kartu(hitam,drawFour), WarnaBaru) :-

    warna(WarnaBaru),
    retract(top_pile(kartu(_, _))),
    asserta(top_pile(kartu(WarnaBaru, _))),

    tambah_kartu(NextPlayer1, ambilKartu(Kartu1)),
    tambah_kartu(NextPlayer1, ambilKartu(Kartu2)),
    tambah_kartu(NextPlayer1, ambilKartu(Kartu3)),
    tambah_kartu(NextPlayer1, ambilKartu(Kartu4)),

    pindah_giliran(NextPlayer2).

