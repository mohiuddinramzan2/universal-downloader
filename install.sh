#!/data/data/com.termux/files/usr/bin/bash
# Setup script - Universal Video Downloader
# Created by Mohiuddin Ramzan

echo "[*] Termux storage পারমিশন সেটআপ হচ্ছে..."
termux-setup-storage

echo "[*] প্যাকেজ আপডেট হচ্ছে..."
pkg update -y && pkg upgrade -y

echo "[*] প্রয়োজনীয় টুলস ইন্সটল হচ্ছে (python, ffmpeg, git)..."
pkg install -y python ffmpeg git

echo "[*] yt-dlp ইন্সটল হচ্ছে..."
pip install -U yt-dlp --break-system-packages 2>/dev/null || pip install -U yt-dlp

chmod +x download.sh

echo ""
echo "[✓] ইন্সটলেশন সম্পন্ন!"
echo "চালু করতে লিখুন: ./download.sh"
