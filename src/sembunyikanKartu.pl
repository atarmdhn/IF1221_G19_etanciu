sembunyikanKartu(NomorUrut) :-
    currentPlayer(PemainAktif),
    player(PemainAktif, ListKartu),
    getLength(ListKartu, PanjangKartu),
    PanjangKartu > 1,
    Indeks is NomorUrut - 1,
    getAndRemove(Indeks, ListKartu, KartuPilihan, ListKartuBaru),
    !,
    asserta(kartu_tersembunyi(PemainAktif, KartuPilihan)),
    retract(player(PemainAktif, _)),
    asserta(player(PemainAktif, ListKartuBaru)),
    kartu(Warna, Jenis) = KartuPilihan,
    format('Kartu ~w-~w pada urutan ~w berhasil disembunyikan secara diam-diam!~n', [Warna, Jenis, NomorUrut]).

sembunyikanKartu(_) :-
    write('Gagal menyembunyikan kartu'), nl.