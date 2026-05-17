:- dynamic(status_uni/1).

% Rule Kartu Biru
kartu(biru, 0). kartu(biru, 1). kartu(biru, 2). kartu(biru, 3). kartu(biru, 4).
kartu(biru, 5). kartu(biru, 6). kartu(biru, 7). kartu(biru, 8). kartu(biru, 9).

kartu(biru, skip). kartu(biru, reverse). kartu(biru, draw_two).

% RUle Kartu kuning
kartu(kuning, 0). kartu(kuning, 1). kartu(kuning, 2). kartu(kuning, 3). kartu(kuning, 4).
kartu(kuning, 5). kartu(kuning, 6). kartu(kuning, 7). kartu(kuning, 8). kartu(kuning, 9).

kartu(kuning, skip). kartu(kuning, reverse). kartu(kuning, draw_two).

% RUle Kartu hijau
kartu(hijau, 0). kartu(hijau, 1). kartu(hijau, 2). kartu(hijau, 3). kartu(hijau, 4).
kartu(hijau, 5). kartu(hijau, 6). kartu(hijau, 7). kartu(hijau, 8). kartu(hijau, 9).

kartu(hijau, skip). kartu(hijau, reverse). kartu(hijau, draw_two).

% RUle Kartu merah
kartu(merah, 0). kartu(merah, 1). kartu(merah, 2). kartu(merah, 3). kartu(merah, 4).
kartu(merah, 5). kartu(merah, 6). kartu(merah, 7). kartu(merah, 8). kartu(merah, 9).

kartu(merah, skip). kartu(merah, reverse). kartu(merah, draw_two).

% Rule wild card
kartu(hitam, wild).
kartu(hitam, draw_four).

number(0).
number(1). 
number(2). 
number(3).
number(4).
number(5).
number(6).
number(7).
number(8).
number(9).

warna(biru).
warna(merah).
warna(hitam).
warna(hijau).
warna(kuning).