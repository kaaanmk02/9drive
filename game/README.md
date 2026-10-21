# Condemned — Oyun Projesi Yedeği

**Tarih:** 21 Ekim 2026
**Kaynak:** `/root/game` (320 MB, venv/.buildozer hariç)

Rogue-like top-down shooter — 'descent into hell' narratifi, 12 Angel boss,
soul tabanlı upgrade sistemi.

## Güvenlik

- Arşivler **AES-256** ile şifreli, başlıklar da şifreli (`-mhe=on`).
- Şifre **bu repoda saklanmaz** — yedek alma sırasında kendi belirlediğin şifreyi kullan.

## İçerik

| Dosya | Boyut | İçerik |
|-------|-------|--------|
| `game_core_20261021.7z` | 17 MB | Tüm proje (kaynak kod, asset'ler, dokümantasyon) |
| `music_ogg.7z` | 41 MB | JRPG Battle Themes — OGG (41 MB, tek dosya) |
| `music_wav_split.7z.001–009` | 30 MB × 8 + 21 MB | JRPG Battle Themes — WAV (273 MB, 9 volüme bölünmüş) |

### game_core içeriği

```
deadcell_demo.py        Ana oyun dosyası (24 KB)
buildozer.spec          Android APK build konfigürasyonu
ldlog.sh                Log script'i
BUILD_GUIDE.txt         Build kılavuzu
BUILD_RAPORU.md         Build raporu (12 KB)
BUILD_SONUCU.md         Build sonucu
BUILD_STATUS.md         Build durumu (16 KB)
SESSION_HANDOFF.md      Oturum devri dokümanı
assest/                 Sprite'lar, boss görselleri, VFX (116 KB açık dosya)
  Boss-Alvaric.png, Boss-Cetus.png, Necromancer_*.png
  Free Mythic Monsters.7z, gothicvania-cemetery-files.zip, ...
sounds/final_theme.mp3  Oyun müziği
*.png                   Player/enemy/gun sprite'ları
```

### Hariç tutulanlar

| Yol | Boyut | Neden |
|-----|-------|-------|
| `venv/` | 23 MB | Python virtualenv — `pip install` ile yeniden kurulur |
| `.buildozer/` | 2.2 GB | Build cache — `buildozer android debug` ile yeniden üretilir |
| `bin/`, `dist/`, `__pycache__/` | küçük | Build çıktısı |
| WAV + OGG müzik | 302 MB | Ayrı dosyalara bölündü (bkz. `music_*`) |

## Geri Yükleme

```sh
pkg install p7zip

# 1. Proje
7z x -pSENIN_SIFREN -o/tmp/game game_core_20261021.7z
mkdir -p ~/game && tar xzf /tmp/game/game_core.tar.gz -C ~/game

# 2. OGG müzik (tek dosya)
7z x -pSENIN_SIFREN -o/root/game/assest music_ogg.7z

# 3. WAV müzik (volümlü — .001'i ver yeter, 7z gerisini bulur)
7z x -pSENIN_SIFREN -o/root/game/assest music_wav_split.7z.001

# 4. Sanal ortamı yeniden kur
cd ~/game
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt
```

## Build (APK)

```sh
cd ~/game
buildozer android debug
# APK: ./bin/
```

## Not

WAV müzik 273 MB — GitHub'ın 100 MB dosya limitine takılmaması için 30 MB volümlere
bölündü. Volümleri **aynı dizinde** tut; `7z x` tek hamlede birleştirir.
