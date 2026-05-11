wildRule(kartu(_,wild), _KartuMeja, WarnaBaru) :-
    warna(WarnaBaru).

wildDrawFour(kartu(_,wild), _KartuMeja, WarnaBaru) :-
    tambah_kartu(NextPlayer, ambilKartu(Kartu1)),
    tambah_kartu(NextPlayer, ambilKartu(Kartu2)),
    tambah_kartu(NextPlayer, ambilKartu(Kartu3)),
    tambah_kartu(NextPlayer, ambilKartu(Kartu4)),
    warna(WarnaBaru).

