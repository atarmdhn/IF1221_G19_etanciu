tampilkanKartu :-
    currentPlayer(PemainAktif),
    kartu_tersembunyi(PemainAktif, _),
    myFindall(Kartu, kartu_tersembunyi(PemainAktif, Kartu), ListRahasia),
    player(PemainAktif, ListTangan),
    gabung_list(ListTangan, ListRahasia, ListBaru),
    retract(player(PemainAktif, _)),
    asserta(player(PemainAktif, ListBaru)),
    retractall(kartu_tersembunyi(PemainAktif, _)),
    
    write('Kartu yang lu umpetin udah balik ke tangan!'), nl.

tampilkanKartu :-
    write('Km tidak memiliki kartu yang sedang disembunyikan.'), nl.