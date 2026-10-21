# Termux Home Yedeği (Essentials)

Telefon sıfırlama / fabrika ayarları öncesi Termux home dizininden **yeniden yaratılması zor** olan kritik verilerin yedeği.

**Tarih:** 21 Ekim 2026
**Boyut:** 60 MB (şifreli 7z → 61 MB tar.gz)

## Güvenlik

- Arşiv **AES-256** ile şifreli, başlıklar da şifreli (`-mhe=on`).
- Şifre **bu repoda saklanmaz.** Yedek alırken kendi şifreni seçtin; geri yüklerken kendi şifreni gir.
- `.ssh/` dizini SSH özel anahtarlarını içerir — şifreyi güçlü tut.

## İçerik

| Yol | Açıklama |
|-----|----------|
| `termux_home_essentials.7z` | Şifreli yedek (başlıklar dahil şifreli) |

### Arşivdeki dizinler

```
.bashrc, .bash_history, .python_history, .viminfo, .wget-hsts, .rediscli_history
.termux/          Termux paket listesi, font, property ayarları
.config/          git config, mpv, croc vb.
.shortcuts/       Termux:Widget shortcut'ları
.omniroute/       RAG/route config
.ssh/             SSH anahtarları
.aria/            Aria2 config
.andromate/       Andromate config
.fr3ktalk/        fr3ktalk config
.maxima/, .llamux/, .local/, .android/, .mpd/
scripts_py/       ~200 Python script (indir.py, pdf.py, doom.py, chatbot vb.)
scripts_sh/       Shell script'ler
rish/             Shizuku rish script'i + dex
Enough-Reborn/    Condemned oyun projesi
texts/, others/, whl/, downloads/
```

## Hariç Tutulanlar

| Yol | Boyut | Neden |
|-----|-------|-------|
| `~/.ollama/` | 56 GB | LLM modelleri — yeniden indirilebilir (`ollama pull`) |
| `scripts_py/videoceviri/whisper.cpp/models/*.bin` | ~2.4 GB | Whisper modelleri — yeniden indirilebilir |
| `cders/` | 65 MB | Ders notları — GitHub 100MB dosya limiti nedeniyle çıkarıldı |
| `tx_launch/` | 82 MB | Launch script'leri — GitHub 100MB dosya limiti nedeniyle çıkarıldı |
| `*.pyc`, `__pycache__/` | küçük | Derlenebilir, yeniden üretilebilir |

**Whisper modellerini geri yüklemek için:**
```sh
cd ~/scripts_py/videoceviri/whisper.cpp/models
bash download-ggml-model.sh tiny base small large-v3-turbo
```

**Ollama modellerini geri yüklemek için:**
```sh
ollama list    # yüklü modeller
ollama pull <model>
```

## Geri Yükleme

```sh
pkg install p7zip
7z x -pSENIN_SIFREN -o/tmp/termux_restore termux_home_essentials.7z
tar xzf /tmp/termux_restore/termux_home_essentials.tar.gz -C /data/data/com.termux/files/home/
```

## Güvenlik

AES-256 şifreli, başlıklar da şifreli (`-mhe=on`) — dosya listesi bile şifre olmadan görülemez.

`.ssh/` dizini SSH özel anahtarlarını içerebilir; yedeği paylaşma.
