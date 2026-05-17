:-include('lihatKartu.pl').
:-include('importantFunctions.pl').
:-include('fact.pl')

hapusElemenKe(1, [_|T], T) :- !.
hapusElemenKe(N, [H|T], [H|SisaT]) :-
    N > 1,
    N1 is N - 1,
    hapusElemenKe(N1, T, SisaT).

uni(NomorUrut):-
        giliran(Pemain), % mengecek giliran
        listKartu(Pemain, ListKartu),
        getLength(ListKartu, 2),
        getElement(NomorUrut, ListKartu, KartuPilihan), %mengambil kartu yang berada di nomor urut

        discard_top(KartuMeja), %mengecek kartu meja (nunggu dari juan)
        valid_kartu(KartuPilihan, KartuMeja) % menyesuaikan kartu di meja dan di tangan (nunggu dari juan)

 
        %menghapus kartu lama
        hapusElemenKe(NomorUrut, ListKartu, LisKartuBaru),
        retract(listKartu(Pemain, _)),
        asserta(listKartu(Pemain, ListKartuBaru))

        %update status uni
        retractall(status_uni(Pemain)), 
        asserta(status_uni(Pemain)),
    
        format('~w memainkan kartu: ~w.~n', [Pemain, KartuPilihan]),
        format('~w menyerukan UNI!~n', [Pemain]),
    
        % Pindah ke giliran berikutnya
        lanjutkan_giliran(KartuPilihan). %nunggu dari juan


