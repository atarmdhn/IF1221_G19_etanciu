
# TUGAS BESAR IF1221 G19 Etanciu

Dahulu, UNI adalah tentang kehangatan yang melingkar. Sebuah ritual tatap muka, tempat tawa berderai, kartu dibanting, dan persahabatan diuji saat kartu Draw Four mendarat tanpa ampun. Ada jiwa dalam setiap gesekan kartunya.

Namun kini, lingkaran hangat itu telah dipaksa mengkerut, bermigrasi ke dalam sunyinya Command Line Interface. Lingkaran yang dulu menghidupkan suasana, sekarang mati dan membeku, menjelma menjadi deretan string dan tulisan kaku di atas layar hitam yang pekat.

Di balik layar itu, bertumpu sebuah Tugas Besar yang menuntut ketabahan. Menghidupkan kembali kegembiraan, UNI bukan lagi soal membagikan kartu secara fisik, melainkan menyusun untaian logika predikat. Di bawah kuasa bahasa Prolog, setiap aturan permainan harus didefinisikan sebagai kebenaran mutlak. Mengajarkan komputer tentang arti giliran yang berputar, warna yang serasi, dan fakta bahwa sebuah permainan kartu bisa direduksi menjadi sekumpulan rules dan facts.

Kita tidak lagi melempar kartu, tetapi kita sedang melakukan query pada sebuah takdir di dalam terminal.


## Etanciu

Etanciu berasal dari akar kata Slavia "Stane", yang berarti "berdiri", "menetap", atau "menjadi teguh". Nama ini mempunyai makna filosofis, yaitu mseseorang atau kelompok yang memiliki pendirian kuat, tidak mudah goyah oleh tantangan (seperti bug di Prolog yang rumit), dan memiliki ketahanan yang tinggi.
Oleh karena itu, Perkenalkan, kami Etanciu siap menjawab masalah-masalah itu

- Naufal Hasbialhaq 13525120
- Vinsensius Juan Setiady 13525039
- Muhammad Fakhriyan Rizki Mahardhika 13525047
- Muhammad Atallah Ramadhan 13525015


## Struktur File

```markdown
IF1221_G19_ETANCIU/
├── docs/
│   ├── Milestone1_G19.pdf 
│   ├── Milestone2_G19.pdf 
│   └── Laporan_G19.pdf
├── src/
│   ├── ambilKartu.pl
│   ├── cekInfo.pl
│   ├── endGame.pl
│   ├── fact.pl
│   ├── godsHand.pl
│   ├── importantFunction.pl
│   ├── lihatCommand.pl
│   ├── lihatKartu.pl
│   ├── loadGame.pl
│   ├── main.pl
│   ├── mainkanKartu.pl
│   ├── rulePemain.pl
│   ├── saveGame.pl
│   ├── sembunyikanKartu.pl
│   ├── startGame.pl
│   ├── tampilkanKartu.pl
│   ├── tangkap.pl
│   ├── tantang.pl
│   └── uni.pl
└── README.md
```


## Cara Menjalankan Program

1. **Jalankan GNU Prolog** dan langsung muat program utama:
   ```bash
   gprolog --consult-file main.pl
   ```
   *Atau, jalankan `gprolog` terlebih dahulu, lalu di dalam interpreter ketik:*
   ```prolog
   | ?- ['main.pl'].
   ```

2. **Mulai Permainan Baru** dengan memanggil predikat `startGame`:
   ```prolog
   | ?- startGame.
   ```

3. **Memuat Permainan yang Disimpan (jika ada)**:
   Jika ingin melanjutkan permainan yang disimpan sebelumnya, jalankan:
   ```prolog
   | ?- loadGame.
   ```

---

## Fitur Utama yang Tersedia

### 1. Mode Permainan
* **Mode Klasik**: Mode individual untuk 2 hingga 4 pemain yang saling berkompetisi menjadi yang tercepat menghabiskan kartu.
* **Mode Turnamen**: Mode permainan tim acak 2v2 (total 4 pemain) untuk memadukan kerja sama tim dan strategi.

### 2. Mekanik Kartu Khusus & Aksi
* **Kartu Aksi Standar**: *Skip* (melewati giliran pemain berikutnya), *Reverse* (mengubah arah putaran giliran), dan *Draw Two* (membuat pemain berikutnya mengambil 2 kartu).
* **Kartu Wild & Wild Draw Four**: Kartu hitam khusus yang memungkinkan pemain mengubah warna aktif, atau memaksa lawan mengambil 4 kartu sekaligus memberikan opsi tantangan.
* **Kartu Mimic**: Kartu hitam unik yang menduplikasi sifat kartu lain di meja.
* **Tantang (Tantangan)**: Mekanik taktis untuk menantang pemain yang mengeluarkan kartu *Wild Draw Four*. Jika tuduhan benar, pelaku terkena hukuman; jika salah, penantang yang dihukum.

### 3. Kontrol & Manajemen Informasi
* **`lihatCommand`**: Menampilkan daftar perintah/aksi utama dan pendukung yang tersedia pada giliran aktif.
* **`lihatKartu`**: Menampilkan daftar kartu yang saat ini berada di tangan pemain aktif.
* **`cekInfo`**: Menampilkan status permainan terkini (jumlah kartu lawan, arah giliran, warna aktif, kartu teratas di discard pile, dll).
* **`sembunyikanKartu(NomorUrut)` & `tampilkanKartu`**: Fitur privasi/taktis untuk menyembunyikan atau menampilkan kartu tertentu dari tangan pemain.
* **`uni` & `tangkap`**: Pemain yang memiliki kartu sisa 1 wajib mengetikkan `uni.`. Jika lupa, pemain lain dapat melakukan `tangkap.` untuk memberi hukuman penambahan kartu.
* **`saveGame` & `loadGame`**: Fitur *save/load* yang memungkinkan menyimpan progres permainan saat ini ke file eksternal dan melanjutkannya kapan saja.
