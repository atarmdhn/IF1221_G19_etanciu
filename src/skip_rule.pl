skipRule(kartu(Warna, skip)) :-
    giliran(Pemain),

    retract(top_pile(kartu(_, _))),
    asserta(top_pile(kartu(Warna, skip))),

    pindah_giliran(NextPlayer1), %skip giliran pemain setelahnya 
    pindah_giliran(NextPlayer2),

    giliran(NextPlayer2).