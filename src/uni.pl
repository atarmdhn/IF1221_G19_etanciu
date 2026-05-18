
hapusElemenKe(1, [_|T], T) :- !.
hapusElemenKe(N, [H|T], [H|SisaT]) :-
    N > 1,
    N1 is N - 1,
    hapusElemenKe(N1, T, SisaT).

uni(NomorUrut):-
    currentPlayer(Pemain), % mengecek giliran
    player(Pemain, ListKartu),
    getLength(ListKartu, 2),
    getElement(NomorUrut, ListKartu, KartuPilihan), %mengambil kartu yang berada di nomor urut

    topCard(KartuMeja),
    isKartuValid(KartuPilihan, KartuMeja), % menyesuaikan kartu di meja dan di tangan 

    %menghapus kartu lama
    hapusElemenKe(NomorUrut, ListKartu, ListKartuBaru),
    retract(player(Pemain, _)),
    asserta(player(Pemain, ListKartuBaru)),

        %update status uni
    retractall(status_uni(Pemain)), 
    asserta(status_uni(Pemain)),
    
    format('~w memainkan kartu: ~w.~n', [Pemain, KartuPilihan]),
    format('~w menyerukan UNI!~n', [Pemain]),
    
        % Pindah ke giliran berikutnya
    prosesEfekdanTurn(KartuPilihan). 

uni(_) :-
    currentPlayer(Pemain),
    write('Perintah tidak valid (kartu tidak cocok / jumlah kartu tidak tepat).'), nl,
    write('Penalti: Anda mendapatkan 1 kartu acak.'), nl,
    
    ambilKartu(KartuHukuman), 
    
    % Masukkan kartu hukuman ke tangan pemain
    player(Pemain, ListKartu),
    myAppend(ListKartu, [KartuHukuman], ListKartuBaru),
    
    retract(player(Pemain, _)),
    asserta(player(Pemain, ListKartuBaru)),
    

    prosesEfekdanTurn(gagal). %lanjut next orang