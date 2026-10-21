# 9drive — Telefon Sıfırlama Sonrası Kurtarma Rehberi

Telefonunu sıfırlamadan önce alınan yedeklerin tamamı burada.
**Depo:** https://github.com/kaaanmk02/9drive

---

## 1. Hemen indir (kritik)

| Dosya | Boyut | İçerik |
|-------|-------|--------|
| `hermes/hermes_backup_20261021.7z` | 23 MB | Hermes Agent tam yedeği (skills, memories, cron, API anahtarları, bot token) |
| `termux/termux_home_essentials.7z` | 60 MB | Termux home yedeği (script'ler, config'ler, SSH anahtarları) |
| `termux/extra/termux_extra_20261021.7z` | 22 MB | `cders/` + `tx_launch/` kaynak kodu |
| `game/game_core_20261021.7z` | 17 MB | Condemned oyun projesi (kaynak, asset'ler, dokümantasyon) |
| `game/music_ogg.7z` | 41 MB | Oyun müziği — OGG |
| `game/music_wav_split.7z.001–009` | 273 MB | Oyun müziği — WAV (9 volüme bölünmüş) |
| `backups/apk_backup.bundle` | 100 KB | APK yedek git bundle'ı |
| `backups/apk_backup_20261020/*.md/.txt` | 7 KB | Uygulama listeleri |

**Toplam repo:** ~350 MB

## 2. Şifreler

İki arşiv de AES-256 ile şifreli ve başlıkları da şifreli (`-mhe=on`).
**Şifreler repoda saklanmaz** — yedek alırken kendi şifreni seçtin; geri yüklerken aynı şifreyi kullan.
Şifrelerini not et; yoksa arşivler açılamaz.

## 3. Geri yükleme sırası

### a) Termux kur
```sh
# Google Play / F-Droid'den Termux + Termux:API kur
pkg update && pkg install p7zip python git
```

### b) Repoyu klonla
```sh
git clone https://github.com/kaaanmk02/9drive.git /sdcard/9drive
cd /sdcard/9drive
```

### c) Termux home yedeğini geri yükle
```sh
7z x -pSENIN_SIFREN -o/tmp/t termux/termux_home_essentials.7z
tar xzf /tmp/t/termux_home_essentials.tar.gz -C /data/data/com.termux/files/home/
```

### d) Termux ek yedeğini geri yükle (cders + tx_launch)
```sh
7z x -pSENIN_SIFREN -o/tmp/extra termux/extra/termux_extra_20261021.7z
cd /tmp/extra
tar xzf cders.tar.gz -C /data/data/com.termux/files/home/
tar xzf tx_launch_src.tar.gz -C /data/data/com.termux/files/home/
```

### e) Hermes yedeğini geri yükle
```sh
cd /sdcard/9drive/hermes
sh restore.sh hermes_backup_20261021.7z SENIN_SIFREN
```
Script otomatik: `p7zip` kurulumunu kontrol eder, arşivi açar, `~/.hermes/` altına
kopyalar, izinleri ayarlar (`.secrets` → 700, içindekiler → 600).

### f) Condemned oyun projesini geri yükle
```sh
7z x -pSENIN_SIFREN -o/tmp/game game/game_core_20261021.7z
mkdir -p ~/game && tar xzf /tmp/game/game_core.tar.gz -C ~/game
cd ~/game
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt

# Müzikleri geri yükle
7z x -pSENIN_SIFREN -o~/game/assest game/music_ogg.7z
7z x -pSENIN_SIFREN -o~/game/assest game/music_wav_split.7z.001   # 7z gerisini bulur
```

### g) APK'ları geri yükle
```sh
# Bundle'ı klonla
git clone backups/apk_backup.bundle /tmp/apk_restore
# ya da APK'ları tek tek kur:
#   termux-open /sdcard/Download/ApkBackup_20261020/*.apk
```

### h) Yeniden indirilebilir büyük veriler
| Veri | Boyut | Komut |
|------|-------|-------|
| Ollama LLM modelleri | 56 GB | `ollama pull <model>` |
| Whisper modelleri | 2.4 GB | `bash ~/scripts_py/videoceviri/whisper.cpp/models/download-ggml-model.sh tiny base small large-v3-turbo` |
| `cders/` | 22 MB | Repoda (bkz. 3d) |
| `tx_launch/` | 12 KB | Repoda (bkz. 3d) |
| `venv/`, `.buildozer/` | 2.2 GB | `pip install` / `buildozer android debug` |

## 4. Uygulama yükleyici listesi

Kurulması gereken uygulamaların paket adları için:
- `backups/apk_backup_20261020/important_apps_list.md` — seçilmiş önemli uygulamalar
- `backups/apk_backup_20261020/installed_apps_list.txt` — tam kurulu liste

## 5. Şifreli arşivleri doğrulama

```sh
# Bütünlüğü test et
7z t -pSENIN_SIFREN hermes/hermes_backup_20261021.7z
7z t -pSENIN_SIFREN termux/termux_home_essentials.7z
7z t -pSENIN_SIFREN termux/extra/termux_extra_20261021.7z
7z t -pSENIN_SIFREN game/game_core_20261021.7z
7z t -pSENIN_SIFREN game/music_wav_split.7z.001     # volümlü

# Yanlış şifre denersen: "Cannot open encrypted archive. Wrong password?"
```

## 6. Güvenlik notları

- `hermes/config.yaml` (bot token içerir) ve API anahtarları **yalnızca şifreli arşivin içinde**.
  Repoda düz metin kopya yok — taramayla doğrulandı.
- `.ssh/` dizini SSH özel anahtarlarını içerir.
- Repo herkese açık; şifrelerini güçlü tut.

---

## Yedekleme kapsamı (ne nerede)

| Veri | Yerde | Boyut |
|------|-------|-------|
| Hermes Agent | `hermes/` | 23 MB |
| Termux home (script, config, SSH) | `termux/` | 60 MB |
| cders + tx_launch | `termux/extra/` | 22 MB |
| Condemned oyun projesi | `game/` | 333 MB |
| APK yedekleri + uygulama listeleri | `backups/` | 107 KB |
| **Toplam** | | **~440 MB** |
