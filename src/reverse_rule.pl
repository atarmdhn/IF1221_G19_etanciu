:-include ('importantFunction.pl')
:-include('startGame.pl')

reverseRule(kartu(_, skip)):-
    getAllPlayers(UrutanLama), % urutanPemain belum ada
    balikUrutan(UrutanLama, UrutanBaru),

    retract(UrutanLama),
    asserta(UrutanBaru).

balikUrutan([], []):- !.

balikUrutan([Head|Tail], TailTerbalik):-
    balikUrutan(Tail, ListTerbalik),
    myAppend(TailTerbalik, [Head], ListTerbalik).