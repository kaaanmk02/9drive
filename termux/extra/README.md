# Termux Ek Yedek (cders + tx_launch)

**Tarih:** 21 Ekim 2026
**Kaynak:** `/data/data/com.termux/files/home/` — ana yedekten hariç tutulan dizinler

Bu arşiv, `termux_home_essentials.7z` içine sığmayan iki dizini kapsar.

## İçerik

| Dosya | Boyut (şifreli) | İçerik |
|-------|-----------------|--------|
| `termux_extra_20261021.7z` | 22 MB | `cders/` + `tx_launch/` kaynak |

### cders/ (65 MB açık, 22 MB sıkıştırılmış)

Ders notları ve kod örnekleri — 1071 `.h`, 408 `.cpp`, 287 `.c`, 237 `.jpg`, 73 `.txt`, 61 `.o`/`.d`, 56 `.cmake`, 44 `.xml`, 38 `.py`

```
dlib/     64 MB  — C++ kaynak kodu ve örnekler
derle/    768 KB — derleyici notları
kod/      280 KB — kod örnekleri
diger/    116 KB — çeşitli
not/      16 KB  — notlar
```

### tx_launch/ (82 MB açık, 12 KB sıkıştırılmış)

Termux launcher aracı (Rust). Kaynak kodu + README + Cargo konfigürasyonu.
`target/` (41 MB) build çıktısı **hariç tutuldu** — `cargo build` ile yeniden üretilir.

## Geri Yükleme

```sh
pkg install p7zip
7z x -pSENIN_SIFREN -o/tmp/extra termux_extra_20261021.7z
cd /tmp/extra
tar xzf cders.tar.gz -C /data/data/com.termux/files/home/
tar xzf tx_launch_src.tar.gz -C /data/data/com.termux/files/home/

# tx_launch yeniden derle (kaynak istiyorsan)
cd /data/data/com.termux/files/home/tx_launch && cargo build --release
```

## Neden ayrı?

GitHub'ın tek dosya limiti 100 MB'dır. Bu iki dizin ana yedekle birleşince
toplam 60 MB + 22 MB = 82 MB olacak ve `.git` boyutu ~130 MB'a çıkacaktı.
Ayrı tutmak repo boyutunu düşük ve geri yüklemeyi modüler tutar.
