numberRule(kartu(Warna, _AngkaPemain), kartu(Warna, _AngkaMeja)).

numberRule(kartu(_WarnaPemain, Angka), kartu(_WarnaMeja, Angka)):-
    number(Angka).

