#!/data/data/com.termux/files/usr/bin/bash
# =====================================================
#  Universal Video Downloader for Termux
#  Supports: YouTube, Facebook, Instagram, TikTok,
#            Twitter/X, Pinterest, and 1000+ more sites
#  Created by Mohiuddin Ramzan
# =====================================================

# ---------- Colors ----------
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
MAGENTA='\033[1;35m'
NC='\033[0m'

SAVE_DIR="$HOME/storage/downloads/UniversalDownloader"
mkdir -p "$SAVE_DIR" 2>/dev/null

banner() {
clear
echo -e "${CYAN}"
cat << "EOF"
 _   _       _                          _
| | | |_ __ (_)_   _____ _ __ ___  __ _| |
| | | | '_ \| \ \ / / _ \ '__/ __|/ _\` | |
| |_| | | | | |\ V /  __/ |  \__ \ (_| | |
 \___/|_| |_|_| \_/ \___|_|  |___/\__,_|_|

  ____                      _                 _
 |  _ \  _____      ___ __ | | ___   __ _  __| | ___ _ __
 | | | |/ _ \ \ /\ / / '_ \| |/ _ \ / _\` |/ _\` |/ _ \ '__|
 | |_| | (_) \ V  V /| | | | | (_) | (_| | (_| |  __/ |
 |____/ \___/ \_/\_/ |_| |_|_|\___/ \__,_|\__,_|\___|_|
EOF
echo -e "${NC}"
echo -e "${YELLOW}      Universal Video Downloader for Termux${NC}"
echo -e "${MAGENTA}      YouTube | Facebook | Instagram | TikTok | X${NC}"
echo -e "${GREEN}            >> Created by Mohiuddin Ramzan <<${NC}"
echo -e "${CYAN}=========================================================${NC}"
}

check_deps() {
    if ! command -v yt-dlp &> /dev/null; then
        echo -e "${RED}[!] yt-dlp পাওয়া যায়নি। ইন্সটল করা হচ্ছে...${NC}"
        pip install -U yt-dlp --break-system-packages 2>/dev/null || pip install -U yt-dlp
    fi
    if ! command -v ffmpeg &> /dev/null; then
        echo -e "${RED}[!] ffmpeg পাওয়া যায়নি। ইন্সটল করা হচ্ছে...${NC}"
        pkg install -y ffmpeg
    fi
}

pause() {
    echo ""
    read -p "$(echo -e ${YELLOW}'চাপুন Enter মেনুতে ফিরতে... '${NC})"
}

download_video() {
    echo ""
    read -p "$(echo -e ${CYAN}'ভিডিও/লিংক পেস্ট করুন: '${NC})" url
    if [ -z "$url" ]; then
        echo -e "${RED}লিংক দেওয়া হয়নি!${NC}"
        pause
        return
    fi

    echo ""
    echo -e "${YELLOW}কোয়ালিটি নির্বাচন করুন:${NC}"
    echo -e " ${GREEN}1)${NC} সেরা কোয়ালিটি (Best)"
    echo -e " ${GREEN}2)${NC} 1080p"
    echo -e " ${GREEN}3)${NC} 720p"
    echo -e " ${GREEN}4)${NC} 480p"
    echo -e " ${GREEN}5)${NC} শুধু অডিও (MP3)"
    read -p "নির্বাচন [1-5]: " q

    case $q in
        1) FORMAT="bestvideo+bestaudio/best" ;;
        2) FORMAT="bestvideo[height<=1080]+bestaudio/best[height<=1080]" ;;
        3) FORMAT="bestvideo[height<=720]+bestaudio/best[height<=720]" ;;
        4) FORMAT="bestvideo[height<=480]+bestaudio/best[height<=480]" ;;
        5) FORMAT="bestaudio" ;;
        *) FORMAT="best" ;;
    esac

    echo ""
    echo -e "${GREEN}[+] ডাউনলোড শুরু হচ্ছে...${NC}"
    echo -e "${CYAN}সংরক্ষণ হবে: $SAVE_DIR${NC}"
    echo ""

    if [ "$q" == "5" ]; then
        yt-dlp -f "$FORMAT" -x --audio-format mp3 \
            -o "$SAVE_DIR/%(title)s.%(ext)s" \
            --embed-thumbnail --add-metadata \
            --no-mtime "$url"
    else
        yt-dlp -f "$FORMAT" --merge-output-format mp4 \
            -o "$SAVE_DIR/%(title)s.%(ext)s" \
            --no-mtime "$url"
    fi

    if [ $? -eq 0 ]; then
        echo ""
        echo -e "${GREEN}[✓] ডাউনলোড সম্পন্ন হয়েছে!${NC}"
        echo -e "${CYAN}ফাইল পাবেন: $SAVE_DIR${NC}"
    else
        echo -e "${RED}[✗] ডাউনলোড ব্যর্থ হয়েছে। লিংক চেক করুন অথবা প্রাইভেট কনটেন্ট কিনা দেখুন।${NC}"
    fi
    pause
}

batch_download() {
    echo ""
    echo -e "${YELLOW}একাধিক লিংক দিতে চাইলে একটি ফাইলে প্রতি লাইনে একটি লিংক রাখুন।${NC}"
    read -p "লিংক লিস্ট ফাইলের পাথ (যেমন: /sdcard/links.txt): " listfile
    if [ ! -f "$listfile" ]; then
        echo -e "${RED}ফাইল পাওয়া যায়নি!${NC}"
        pause
        return
    fi
    echo -e "${GREEN}[+] ব্যাচ ডাউনলোড শুরু হচ্ছে...${NC}"
    yt-dlp -f "bestvideo[height<=720]+bestaudio/best[height<=720]" \
        --merge-output-format mp4 \
        -o "$SAVE_DIR/%(title)s.%(ext)s" \
        -a "$listfile"
    echo -e "${GREEN}[✓] ব্যাচ ডাউনলোড সম্পন্ন!${NC}"
    pause
}

update_tool() {
    echo -e "${YELLOW}[*] yt-dlp আপডেট করা হচ্ছে...${NC}"
    pip install -U yt-dlp --break-system-packages 2>/dev/null || pip install -U yt-dlp
    echo -e "${GREEN}[✓] আপডেট সম্পন্ন!${NC}"
    pause
}

main_menu() {
    while true; do
        banner
        echo -e "${YELLOW}মেনু নির্বাচন করুন:${NC}"
        echo -e " ${GREEN}1)${NC} সিঙ্গেল ভিডিও ডাউনলোড করুন"
        echo -e " ${GREEN}2)${NC} ব্যাচ ডাউনলোড (একাধিক লিংক)"
        echo -e " ${GREEN}3)${NC} yt-dlp আপডেট করুন"
        echo -e " ${GREEN}4)${NC} বের হন (Exit)"
        echo ""
        read -p "নির্বাচন [1-4]: " choice
        case $choice in
            1) download_video ;;
            2) batch_download ;;
            3) update_tool ;;
            4) echo -e "${MAGENTA}ধন্যবাদ! আবার দেখা হবে। - Mohiuddin Ramzan${NC}"; exit 0 ;;
            *) echo -e "${RED}ভুল অপশন!${NC}"; sleep 1 ;;
        esac
    done
}

check_deps
main_menu
