# 🎬 Universal Video Downloader (Termux)

**Created by Mohiuddin Ramzan**

A Termux tool to download videos from almost any link — YouTube, Facebook, Instagram, TikTok, Twitter/X, Pinterest, and 1000+ other sites (powered by [yt-dlp](https://github.com/yt-dlp/yt-dlp)).

## ✨ Features

- ✅ Download from any public video link
- ✅ Quality selection (Best / 1080p / 720p / 480p)
- ✅ Audio-only download option (MP3)
- ✅ Batch download (multiple links at once)
- ✅ Simple menu-driven interface
- ✅ Auto-installs dependencies

## 📦 Installation

```bash
git clone https://github.com/mohiuddinramzan2/universal-downloader.git
cd universal-downloader
chmod +x install.sh
./install.sh
```

## ▶️ Usage

```bash
./download.sh
```

Pick an option from the menu, paste the link, choose a quality — done!

Files are saved to: `~/storage/downloads/UniversalDownloader/`

## ⚠️ Important Notes

- Only download content you **own** or that is **public/permitted** for download.
- Downloading or reusing copyrighted content without permission may violate the law — always respect the platform's Terms of Service.
- This tool may not work for private or login-required content.

## 🛠️ Tech Stack

- Bash
- yt-dlp
- ffmpeg (for muxing/audio conversion)

---

**Developed with ❤️ by Mohiuddin Ramzan**
