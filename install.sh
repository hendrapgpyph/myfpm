#!/bin/bash

# Pastikan dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "Error: Installer ini harus dijalankan sebagai root!"
  exit 1
fi

echo "==> Menginstall MYFPM ke sistem..."

# Jika dijalankan secara lokal di folder project atau via curl dari GitHub
if [ -f "./myfpm" ]; then
    cp ./myfpm /usr/local/bin/myfpm
else
    # Fallback download dari GitHub jika dijalankan via one-liner online
    REPO_URL="https://raw.githubusercontent.com/hendrapgpyph/myfpm/main/myfpm"
    curl -sL "$REPO_URL" -o /usr/local/bin/myfpm
fi

if [ $? -ne 0 ]; then
  echo "Error: Gagal menyalin atau mendownload myfpm."
  exit 1
fi

# Berikan izin eksekusi
chmod +x /usr/local/bin/myfpm

echo "===================================================="
echo " SUKSES! MYFPM berhasil diinstall."
echo " Ketik 'myfpm -h' untuk melihat daftar perintah."
echo "===================================================="
