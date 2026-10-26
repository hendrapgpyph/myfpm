#!/bin/bash

# Pastikan dijalankan sebagai root
if [ "$EUID" -ne 0 ]; then
  echo "Error: Updater ini harus dijalankan sebagai root!"
  exit 1
fi

echo "===================================================="
echo "             MYFPM - Self Updater                   "
echo "===================================================="
echo "==> Mengunduh versi terbaru MYFPM dari GitHub..."

TARGET_BIN="/usr/local/bin/myfpm"
TEMP_FILE="/tmp/myfpm_latest.$$"
REPO_URL="https://raw.githubusercontent.com/hendrapgpyph/myfpm/main/myfpm"

# Jika dijalankan secara lokal di folder project atau via curl dari GitHub
if [ -f "./myfpm" ]; then
    cp ./myfpm "$TEMP_FILE"
else
    curl -sL "$REPO_URL" -o "$TEMP_FILE"
fi

if [ $? -ne 0 ] || [ ! -s "$TEMP_FILE" ]; then
    echo "Error: Gagal mengunduh file MYFPM terbaru. Periksa koneksi internet Anda."
    rm -f "$TEMP_FILE"
    exit 1
fi

# Validasi file bash
if ! head -n 1 "$TEMP_FILE" | grep -q "#!/bin/bash"; then
    echo "Error: File yang diunduh tidak valid."
    rm -f "$TEMP_FILE"
    exit 1
fi

# Backup file lama jika ada
if [ -f "$TARGET_BIN" ]; then
    cp "$TARGET_BIN" "${TARGET_BIN}.bak" 2>/dev/null
fi

# Pasang file baru
mv "$TEMP_FILE" "$TARGET_BIN"
chmod +x "$TARGET_BIN"

echo "===================================================="
echo " SUKSES! MYFPM berhasil diperbarui ke versi terbaru."
echo " Ketik 'myfpm -h' untuk melihat menu bantuan."
echo "===================================================="
