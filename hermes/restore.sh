#!/system/bin/sh
# Hermes Agent geri yükleme scripti
# Kullanım:
#   sh restore.sh <arşiv.7z> <şifre>
#   (şifreyi istemezseniz arşiv şifresiz olmalıdır)
#
# Bu script Termux'ta çalışır. 7z yüklü olmalı:
#   pkg install p7zip
#   (yoksa: apt-get install -y p7zip-full)

set -e

ARCHIVE="${1:?Kullanım: sh restore.sh <arşiv.7z> <şifre>}"
PASSWORD="${2:-}"

echo "=== Hermes Backup Restore ==="
echo "Arşiv: $ARCHIVE"

# 7z kontrol
if ! command -v 7z >/dev/null 2>&1; then
    echo "7z bulunamadı, kuruluyor..."
    pkg install -y p7zip 2>/dev/null || apt-get install -y p7zip-full
fi

# Şifreli arşivi çıkar
echo "Arşiv çıkarılıyor..."
if [ -n "$PASSWORD" ]; then
    7z x -p"$PASSWORD" -o/tmp/hermes_restore "$ARCHIVE" -y
else
    7z x -o/tmp/hermes_restore "$ARCHIVE" -y
fi

# Hermes home'a kopyala
DEST="/data/data/com.termux/files/home/.hermes"
mkdir -p "$DEST"

echo "Geri yükleniyor: $DEST"
cp -a /tmp/hermes_restore/hermes_backup/. "$DEST/"

# İzinler
chmod 700 "$DEST"
chmod 700 "$DEST/.secrets" 2>/dev/null
chmod 600 "$DEST/.secrets"/* 2>/dev/null
chmod 600 "$DEST/config.yaml" 2>/dev/null

echo ""
echo "=== Tamamlandı ==="
echo "Geri yüklenen: $DEST"
echo ""
echo "API anahtarları: $DEST/.secrets/"
echo "  - auth.json      (Hermes auth)"
echo "  - hermes.env     (Hermes env)"
echo "  - ponytail.env   (ANTHROPIC_API_KEY)"
echo "  - proxy.env      (OPENROUTER_API_KEY)"
echo ""
echo "Sonraki adımlar:"
echo "  1. .secrets/ içeriğini ilgili plugin dizinlerine kopyala"
echo "     (plugins/ponytail/.env, proxy/.env)"
echo "  2. Termux'u yeniden başlat"
echo "  3. hermes komutunu çalıştır"
