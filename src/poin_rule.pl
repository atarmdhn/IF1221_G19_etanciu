poin(kartu(_, N), N) :-
    number(N).

poin(kartu(_, reverse), 10).
poin(kartu(_, skip), 10).
poin(kartu(_, draw_two), 10).

poin(kartu(hitam, wild), 20).
poin(kartu(hitam, drawfour), 20).