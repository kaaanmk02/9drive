# Hermes Agent Yedeği

Telefon sıfırlama / fabrika ayarları öncesi Hermes Agent tam yedeği.

**Tarih:** 21 Ekim 2026
**Boyut:** 23 MB (şifreli 7z, 80 MB açık)

## Güvenlik

- Arşiv **AES-256** ile şifreli, başlıklar da şifreli (`-mhe=on`) — şifre olmadan dosya listesi bile görünmez.
- Şifre **bu repoda saklanmaz.** Yedek alırken kendi şifreni seçtin; geri yüklerken aşağıdaki komutta kendi şifreni gir.
- API anahtarları ve `config.yaml` (içinde bot token var) **yalnızca şifreli arşivin içinde** bulunur. Repoda düz metin kopya yok.

## İçerik

| Yol | Açıklama |
|-----|----------|
| `hermes_backup_20261021.7z` | Şifreli tam yedek (başlıklar dahil şifreli) |
| `restore.sh` | Termux'ta geri yükleme scripti (şifreyi komut satırından alır) |

## Arşiv İçeriği

```
hermes_backup/
├── .secrets/              # API anahtarları + auth (şifreli)
│   ├── auth.json          # Hermes kimlik doğrulama
│   ├── hermes.env         # Hermes env
│   ├── ponytail.env       # ANTHROPIC_API_KEY
│   └── proxy.env          # OPENROUTER_API_KEY
├── config.yaml            # Ana yapılandırma (bot token içerir)
├── config.yaml.bak
├── SOUL.md                # Agent kimliği
├── skills/                # 157 skill dosyası (57 MB)
│   ├── mlops/
│   ├── autonomous-ai-agents/
│   ├── software-development/
│   └── ...
├── memories/              # MEMORY.md + USER.md
├── cron/                  # Zamanlanmış görevler + execution db
├── profiles/              # default profil
├── plugins/               # ponytail, web-search-plus
├── platforms/
├── proxy/
├── pylibs/
└── state/
```

## Geri Yükleme (Termux)

```sh
# 1. Bu klasörü kopyala
#    /sdcard/Download/9drive/hermes/

# 2. Termux'ta çalıştır (şifreyi kendi belirlediğin şifreyle değiştir)
cd /sdcard/Download/9drive/hermes
sh restore.sh hermes_backup_20261021.7z SENIN_SIFREN
```

Script otomatik olarak:
- `p7zip` kurulumunu kontrol eder / kurar
- Arşivi şifrenle `/tmp/hermes_restore` altına açar
- `~/.hermes/` altına kopyalar
- İzinleri ayarlar (`.secrets` → 700, içindekiler → 600)

## Elle Geri Yükleme

```sh
pkg install p7zip
7z x -pSENIN_SIFREN -o/tmp/hermes_restore hermes_backup_20261021.7z
mkdir -p ~/.hermes
cp -a /tmp/hermes_restore/hermes_backup/. ~/.hermes/
chmod 700 ~/.hermes
chmod 700 ~/.hermes/.secrets
chmod 600 ~/.hermes/.secrets/*
```

## Not

`config.yaml` içindeki `bot_token` ve API anahtarları **şifreli arşivin içinde**.
Reponun herkese açık olduğunu unutma; şifreni güçlü tut ve repoyu gereksiz yere paylaşma.
