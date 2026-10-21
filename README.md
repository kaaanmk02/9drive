# 9drive — Telefon Sıfırlama Sonrası Kurtarma Rehberi

Telefonunu sıfırlamadan önce alınan yedeklerin tamamı burada.
**Depo:** https://github.com/kaaanmk02/9drive

---

## 1. Hemen indir (kritik)

| Dosya | Boyut | İçerik |
|-------|-------|--------|
| `hermes/hermes_backup_20261021.7z` | 23 MB | Hermes Agent tam yedeği (skills, memories, cron, API anahtarları, bot token) |
| `termux/termux_home_essentials.7z` | 60 MB | Termux home yedeği (script'ler, config'ler, SSH anahtarları) |
| `backups/apk_backup.bundle` | 100 KB | APK yedek git bundle'ı |
| `backups/apk_backup_20261020/important_apps_list.md` | 3 KB | Önemli uygulama listesi (paket adları) |
| `backups/apk_backup_20261020/installed_apps_list.txt` | 4.5 KB | Kurulu uygulama listesi |

## 2. Şifreler

İki arşiv de AES-256 ile şifreli ve başlıkları da şifreli (`-mhe=on`).
**Şifreler repoda saklanmaz** — yedek alma sırasında kendi belirlediğin şifreleri kullan.
Yedekleri alırken kullandığın şifreleri not et; yoksa arşivler açılamaz.

## 3. Geri yükleme sırası

### a) Termux kur
```sh
# Google Play / F-Droid'den Termux + Termux:API kur
pkg update && pkg install p7zip python git
```

### b) Termux home yedeğini geri yükle
```sh
git clone https://github.com/kaaanmk02/9drive.git /sdcard/9drive
cd /sdcard/9drive
7z x -pSENIN_SIFREN -o/tmp/t termux/termux_home_essentials.7z
tar xzf /tmp/t/termux_home_essentials.tar.gz -C /data/data/com.termux/files/home/
```

### c) Hermes yedeğini geri yükle
```sh
cd /sdcard/9drive/hermes
sh restore.sh hermes_backup_20261021.7z SENIN_SIFREN
```

### d) APK'ları geri yükle
```sh
# Bundle'ı klonla (içindeki commit'i restore et)
git clone backups/apk_backup.bundle apk_restore
# ya da tek tek APK'ları cur ile indirip kur:
#   pkg install termux-api
#   for f in *.apk; do termux-open "$f"; done
```

### e) Yeniden indirilebilir büyük veriler
| Veri | Boyut | Komut |
|------|-------|-------|
| Ollama LLM modelleri | 56 GB | `ollama pull <model>` |
| Whisper modelleri | 2.4 GB | `bash ~/scripts_py/videoceviri/whisper.cpp/models/download-ggml-model.sh tiny base small large-v3-turbo` |
| `cders/` ders notları | 65 MB | GitHub'a sığmadı — eski telefon yedeğinden al |
| `tx_launch/` launch script'leri | 82 MB | GitHub'a sığmadı — eski telefon yedeğinden al |

## 4. Uygulama yükleyici listesi

Kurulması gereken uygulamaların paket adları için:
- `backups/apk_backup_20261020/important_apps_list.md` — seçilmiş önemli uygulamalar
- `backups/apk_backup_20261020/installed_apps_list.txt` — tam kurulu liste

## 5. Şifreli arşivleri doğrulama

```sh
# Şifresiz bakmak (başlıklar şifreli ise içerik listesi görünmez)
7z l -pSENIN_SIFREN hermes/hermes_backup_20261021.7z | head

# Bütünlüğü test et
7z t -pSENIN_SIFREN termux/termux_home_essentials.7z
```

---

**Not:** `hermes/config.yaml` ve API anahtarları yalnızca şifreli arşivin içindedir.
Repo herkese açıktır; şifrelerini güçlü tut.
