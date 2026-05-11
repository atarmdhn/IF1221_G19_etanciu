reverseRule(kartu(_, skip)):-
    urutanPemain(UrutanLama), % urutanPemain belum ada
    balikUrutan(UrutanLama, UrutanBaru),

    retract(UrutanLama),
    asserta(UrutanBaru).

balikUrutan([], []):- !.

balikUrutan([Head|Tail], TailTerbalik):-
    balikUrutan(Tail, ListTerbalik),
    append(TailTerbalik, [Head], ListTerbalik).

