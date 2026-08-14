#!/bin/bash

URL="$1"
ARTIST="$2"
TITLE="$3"
ALBUM="${4:-Unknown}"

if [ -z "$URL" ] || [ -z "$ARTIST" ] || [ -z "$TITLE" ]; then
    echo "Usage: $0 <url> <artist> <song> [album]"
    exit 1
fi

TEMP_DIR=$(mktemp -d)
FILENAME="${ARTIST} - ${TITLE}"



# Change this to the directory where you want downloaded songs to be saved
OUTPUT_DIR="$HOME/music"
OUTPUT_FILE="${OUTPUT_DIR}/${FILENAME}.opus"



# Remove temporary directory when the script exits
trap 'rm -rf "$TEMP_DIR"' EXIT
FILENAME="${ARTIST} - ${TITLE}"

yt-dlp \
    --remote-components ejs:github \
    --extractor-args "youtube:player_client=web_embedded" \
    -f "bestaudio[acodec=opus]" \
    -x \
    --audio-format opus \
    -o "${TEMP_DIR}/audio.%(ext)s" \
    "$URL"

# Add metadata without re-encoding the audio
ffmpeg \
    -i "${TEMP_DIR}/audio.opus" \
    -map 0:a \
    -c:a copy \
    -metadata "artist=${ARTIST}" \
    -metadata "title=${TITLE}" \
                -metadata "album=${ALBUM}" \
    -y \
    "${TEMP_DIR}/final.opus" \
&& mv "${TEMP_DIR}/final.opus" "${OUTPUT_FILE}"

# Colors
CYAN='\033[38;5;81m'
PURPLE='\033[38;5;141m'
GREEN='\033[38;5;114m'
GRAY='\033[38;5;245m'
WHITE='\033[38;5;255m'
RESET='\033[0m'

echo
echo -e "${PURPLE}╭────────────────────────────────────────╮${RESET}"
echo -e "${PURPLE}│${RESET}  ${CYAN}♫  Download complete${RESET}              ${PURPLE}│${RESET}"
echo -e "${PURPLE}├────────────────────────────────────────┤${RESET}"
echo -e "${PURPLE}│${RESET}  ${GRAY}Artist${RESET}  ${WHITE}${ARTIST}${RESET}"
echo -e "${PURPLE}│${RESET}  ${GRAY}Title ${RESET}  ${WHITE}${TITLE}${RESET}"
echo -e "${PURPLE}│${RESET}  ${GRAY}Album ${RESET}  ${WHITE}${ALBUM}${RESET}"
echo -e "${PURPLE}│${RESET}  ${GRAY}File  ${RESET}  ${GREEN}${FILENAME}.opus${RESET}"
echo -e "${PURPLE}╰────────────────────────────────────────╯${RESET}"
echo
