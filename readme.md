# MyFPM - PHP & FPM Manager for CWP (CentOS Web Panel / AlmaLinux)

`myfpm` adalah CLI utility script berbasis Bash yang dirancang khusus untuk mempermudah manajemen instalasi multiple versi PHP, dukungan Redis Server & Extension, lokasi & editor file `php.ini`, restart service FPM/Redis/Apache, konfigurasi FPM pool per-user, hingga otomatisasi integrasi dengan Apache Web Server di environment CWP (CentOS Web Panel / AlmaLinux 7, 8, dan 9).

---

## 🚀 Fitur Utama

- **Auto OS Detection:** Otomatis mendeteksi versi OS (RHEL/CentOS/AlmaLinux 7, 8, atau 9) dan menyesuaikan repository EPEL & Remi yang dibutuhkan.
- **Full PHP & Redis Installer:** Menginstall versi PHP pilihan lengkap dengan ekstensi esensial (GD, MBString, OPcache, MySQLnd, BCMath, Intl, Sodium, dan PECL Redis), serta mengkonfigurasi Redis Server secara otomatis.
- **PHP INI File Locator & Quick Editor:** Cepat mencari lokasi `php.ini`, `php-fpm.conf`, serta direktori pool per versi PHP, dan bisa langsung membuka editor (`nano`/`vi`) dengan flag `-e` / `edit`.
- **Flexible Version Normalization:** Mendukung berbagai format penulisan versi PHP secara otomatis (contoh: `81`, `8.1`, `php81`, `php8.1`, `81.ini`).
- **Unified Restart Manager:** Mempermudah restart service per versi PHP-FPM (`myfpm restart 81`), Redis (`myfpm restart redis`), Apache (`myfpm restart apache`), maupun seluruh service sekaligus (`myfpm restart all`).
- **Automated User FPM Pool:** Membuat file konfigurasi pool FPM khusus untuk user sistem secara instan, lengkap dengan pengaturan socket dan panduan `.htaccess`.
- **Global PHP Shortcuts:** Membuat shortcut global per versi PHP (contoh: `php81`, `php82`, `php74`) sehingga bisa langsung dipakai menjalankan perintah CLI/Artisan tanpa repot set alias manual.
- **Session PHP Switching:** Memindahkan versi PHP aktif di sesi terminal saat ini dengan mudah menggunakan `source myfpm use {version}` (dapat digunakan oleh user non-root).

---

## 📥 Cara Install (One-Liner Installer)

Masuk ke server VPS Anda sebagai `root`, kemudian jalankan perintah berikut untuk menginstall `myfpm` ke sistem:

```bash
curl -sL https://raw.githubusercontent.com/hendrapgpyph/myfpm/main/install.sh | bash
```

---

## 📖 Panduan Penggunaan (Usage)

Setelah terinstall, Anda bisa mengetikkan `myfpm -h` di terminal untuk melihat bantuan menu. Berikut adalah daftar perintah yang tersedia:

### 1. Install Versi PHP & Ekstensi Lengkap (Termasuk Redis)

Menginstall PHP beserta FPM, Redis Server, dan modul-modul pentingnya:

```bash
myfpm -i 81
# Format versi lain yang didukung: myfpm -i 8.1, myfpm -i php8.1
```

### 2. Cek Lokasi & Edit File Konfigurasi (php.ini)

Melihat lokasi file `php.ini` dan konfigurasi FPM:

```bash
myfpm 81.ini
# atau
myfpm ini 8.1
```

Membuka file `php.ini` langsung di terminal menggunakan editor (`nano` / `vi`):

```bash
myfpm 81.ini -e
# atau
myfpm ini 81 edit
```

### 3. Restart Service (PHP-FPM, Redis, Apache)

Merestart service PHP-FPM spesifik versi:

```bash
myfpm restart 81
# atau
myfpm restart 8.1
```

Merestart Redis Server:

```bash
myfpm restart redis
```

Merestart seluruh service terkait sekaligus (semua PHP-FPM, Redis, & Apache):

```bash
myfpm restart all
```

### 4. Manajemen Service Redis

Mengelola service Redis secara khusus:

```bash
myfpm redis status
myfpm redis restart
myfpm redis start
myfpm redis stop
myfpm redis install
```

### 5. Membuat FPM Pool untuk User Sistem

Membuat konfigurasi socket FPM khusus untuk user tertentu (misalnya user `billing` atau `akademik`) menggunakan versi PHP tertentu:

```bash
myfpm -u billing -v 72
# Variasi format lain yang didukung:
myfpm -u billing 72
myfpm user billing 72
```

*Script ini akan otomatis menghasilkan path socket `/run/php72-billing.sock` dan mencetak blok kode `.htaccess` yang siap Anda pasang di direktori project web.*

### 6. Switch Versi PHP di Sesi Terminal (User & Root)

Mengganti versi PHP dan Composer aktif untuk sesi terminal saat ini (bisa dijalankan oleh user biasa maupun root):

```bash
source myfpm use 81
# atau
. myfpm use 81
```

Untuk kembali ke versi default bawaan CWP:

```bash
source myfpm use default
```

### 7. Menjalankan Command PHP Spesifik (Global CLI)

Anda dapat langsung mengeksekusi versi PHP tertentu tanpa harus melakukan `use` terlebih dahulu (bisa digunakan oleh user biasa tanpa root):

```bash
php81 artisan config:clear
php82 artisan cache:clear
php74 -v
```

---

## 🛠️ Validasi Keamanan & Sistem

Script ini dilengkapi dengan beberapa validasi untuk mencegah error di server:

* **Scoped Root Privilege Check:** Membatasi eksekusi root hanya pada perintah sistem (instalasi, buat pool, restart service), sedangkan perintah seperti `use`, `ini`, `redis status`, dan `help` dapat diakses oleh user biasa (non-root).
* **OS Support Validation:** Mencegah instalasi versi PHP lama (seperti PHP < 8.0) di AlmaLinux/RHEL 9.
* **System User Check:** Memastikan user Linux tujuan benar-benar terdaftar di server (`/etc/passwd`) sebelum membuat file pool FPM.
* **Smart Repository Check:** Memeriksa ketersediaan repo Remi/EPEL via `rpm -q` agar tidak error jika repo sudah ada, dan menghindari `yum update` global yang berisiko.
* **Yum Error Handling:** Menghentikan proses secara aman jika terjadi kegagalan unduh atau instalasi dari repository.

---

## 📄 License

Open-source project licensed under the [MIT License](LICENSE).
