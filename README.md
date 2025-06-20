# JedaBerita

Sebuah proyek Flutter baru yang menampilkan berita terbaru dari sebuah API.

## About

JedaBerita adalah aplikasi Flutter sederhana yang dirancang untuk mengambil dan menampilkan artikel berita terbaru. Aplikasi ini menggunakan API berita eksternal untuk menyediakan informasi terkini, yang diformat agar mudah dibaca. Proyek ini berfungsi sebagai contoh bagaimana mengintegrasikan API pihak ketiga dalam aplikasi Flutter, menangani data JSON, dan menyajikannya dalam antarmuka yang ramah pengguna.

## Fitur

* **Menampilkan Berita Terbaru**: Mengambil dan menampilkan artikel berita terkini.
* **Detail Artikel**: Setiap berita menampilkan judul, deskripsi (jika tersedia), dan tanggal publikasi.
* **Dukungan Gambar**: Menampilkan gambar untuk setiap artikel jika `image_url` disediakan oleh API. Dilengkapi dengan placeholder untuk gambar yang gagal dimuat.
* **Format Tanggal Lokal**: Tanggal diformat sesuai dengan lokal Indonesia (`id_ID`).
* **Indikator Pemuatan**: Menampilkan indikator loading saat mengambil data berita.
* **Penanganan Error**: Menampilkan pesan error jika data berita gagal dimuat.

## API yang Digunakan

Proyek ini menggunakan [Newsdata.io API](https://newsdata.io/) untuk mengambil artikel berita.
Endpoint API yang digunakan adalah:
`https://newsdata.io/api/1/latest?apikey=YOUR_API_KEY&country=id&language=id&category=crime,politics,world,top,education&timezone=Asia/Jakarta`

**Catatan**: Kunci API tertanam langsung dalam file `news_service.dart` untuk kesederhanaan dalam contoh ini. Untuk aplikasi produksi, sangat disarankan untuk mengamankan kunci API Anda menggunakan variabel lingkungan atau metode yang lebih aman lainnya.

### Prasyarat

Sebelum Anda memulai, pastikan Anda telah menginstal yang berikut:

* [Flutter SDK](https://flutter.dev/docs/get-started/install) (versi yang kompatibel dengan SDK `^3.7.2` atau lebih baru).
* [Dart SDK](https://dart.dev/get-dart)
* [VS Code](https://code.visualstudio.com/) atau Android Studio dengan plugin Flutter dan Dart terinstal.

### Kloning Repositori

```bash
git clone [https://github.com/fergoajah/JedaBerita.git](https://github.com/fergoajah/JedaBerita.git)
cd JedaBerita
```

### Install Depedensi 
```bash
flutter pub get
```

## Screenshot
![Screenshot_2025-06-20-19-35-57-444_com example api_flutter2](https://github.com/user-attachments/assets/cad47030-e760-4359-a1b0-6ddb7fc5cd38)
