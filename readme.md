# MyFPM - PHP & FPM Manager for CWP (CentOS Web Panel / AlmaLinux)

`myfpm` adalah CLI utility script berbasis Bash yang dirancang khusus untuk mempermudah manajemen instalasi multiple versi PHP, konfigurasi FPM pool per-user, manajemen versi PHP CLI (switching), hingga otomatisasi integrasi dengan Apache Web Server di environment CWP (CentOS Web Panel / AlmaLinux 7, 8, dan 9).

---

## 🚀 Fitur Utama

- **Auto OS Detection:** Otomatis mendeteksi versi OS (RHEL/CentOS/AlmaLinux 7, 8, atau 9) dan menyesuaikan repository EPEL & Remi yang dibutuhkan.
- **Full PHP Extensions Installer:** Menginstall versi PHP pilihan lengkap dengan ekstensi esensial (GD, MBString, OPcache, MySQLnd, BCMath, Intl, Sodium, dll).
- **Automated User FPM Pool:** Membuat file konfigurasi pool FPM khusus untuk user sistem secara instan, lengkap dengan pengaturan socket dan panduan `.htaccess`.
- **Global PHP Shortcuts:** Membuat shortcut global per versi PHP (contoh: `php81`, `php82`, `php74`) sehingga bisa langsung dipakai menjalankan perintah CLI/Artisan tanpa repot set alias manual.
- **Session PHP Switching:** Memindahkan versi PHP aktif di sesi terminal saat ini dengan mudah menggunakan `myfpm use {version}`.

---

## 📥 Cara Install (One-Liner Installer)

Masuk ke server VPS Anda sebagai `root`, kemudian jalankan perintah berikut untuk menginstall `myfpm` ke sistem:

```bash
curl -O [https://raw.githubusercontent.com/hendrapgpyph/myfpm/main/install.sh](https://raw.githubusercontent.com/hendrapgpyph/myfpm/main/install.sh) && sh install.sh

```

---

## 📖 Panduan Penggunaan (Usage)

Setelah terinstall, Anda bisa mengetikkan `myfpm -h` di terminal untuk melihat bantuan menu. Berikut adalah daftar perintah yang tersedia:

### 1. Install Versi PHP & Ekstensi Lengkap

Menginstall PHP beserta FPM dan modul-modul pentingnya (otomatis mendeteksi versi Remi & mengaktifkan `proxy_fcgi` di Apache).

```bash
myfpm -i 81
# Contoh lain: myfpm -i 74, myfpm -i 82, myfpm -i 83

```

### 2. Membuat FPM Pool untuk User Sistem

Membuat konfigurasi socket FPM khusus untuk user tertentu (misalnya user `akademik`) menggunakan versi PHP tertentu.

```bash
myfpm -u akademik -v 81

```

*Script ini akan otomatis menghasilkan path socket `/run/php81-akademik.sock` dan mencetak blok kode `.htaccess` yang siap Anda pasang di direktori project web.*

### 3. Switch Versi PHP di Sesi Terminal

Mengganti versi PHP dan Composer aktif untuk sesi terminal saat ini:

```bash
myfpm use 81

```

Untuk kembali ke versi default bawaan CWP:

```bash
myfpm use default

```

### 4. Menjalankan Command PHP Spesifik (Global CLI)

Anda dapat langsung mengeksekusi versi PHP tertentu tanpa harus melakukan `use` terlebih dahulu (sangat berguna untuk cron job atau perintah Artisan):

```bash
php81 artisan config:clear
php82 artisan cache:clear
php74 -v

```

---

## 🛠️ Validasi Keamanan & Sistem

Script ini dilengkapi dengan beberapa validasi untuk mencegah error di server:

* **Root Privilege Check:** Menolak eksekusi jika tidak dijalankan sebagai `root`.
* **OS Support Validation:** Mencegah instalasi versi PHP lama (seperti PHP < 8.0) di AlmaLinux/RHEL 9.
* **System User Check:** Memastikan user Linux tujuan benar-benar terdaftar di server (`/etc/passwd`) sebelum membuat file pool FPM.
* **Yum Error Handling:** Menghentikan proses secara aman jika terjadi kegagalan unduh atau instalasi dari repository.

---

## 📄 License

Open-source project licensed under the [MIT License](https://www.google.com/search?q=LICENSE).

```

```
