#!/data/data/com.termux/files/usr/bin/bash
# Setup script - Universal Video Downloader
# Created by Mohiuddin Ramzan

echo "[*] Setting up Termux storage permission..."
termux-setup-storage

echo "[*] Updating packages..."
pkg update -y && pkg upgrade -y

echo "[*] Installing required tools (python, ffmpeg, git)..."
pkg install -y python ffmpeg git

echo "[*] Installing yt-dlp..."
pip install -U yt-dlp --break-system-packages 2>/dev/null || pip install -U yt-dlp

chmod +x download.sh

echo ""
echo "[✓] Installation complete!"
echo "Run it with: ./download.sh"
