#!/usr/bin/env bash

set -o xtrace

AUDIOBOOKS_DIR="$HOME/audiobooks"
mkdir -p "$AUDIOBOOKS_DIR" && sudo chown -R $USER:$USER $AUDIOBOOKS_DIR

echo "Updating library..."
# audible library export

cat library.tsv | tail -n+2 | cut -f2 | nl -w2 -s'> ' | less
read -e -p "Which audiobook do you want to download: " -i 1 LINE 

LINE=$(($LINE + 1))
NAME=$(< library.tsv awk -F'\t' "FNR=="${LINE}" {print \$2}")
ID=$(< library.tsv awk -F'\t' "FNR=="${LINE}" {print \$1}")

DOWNLOAD_DIR="$HOME/audible_tmp/$ID"
mkdir -p $DOWNLOAD_DIR && sudo chown -R $USER:$USER $DOWNLOAD_DIR

echo "Downloading $NAME in temporal folder $DOWNLOAD_DIR"

audible download \
        --asin "$ID" \
        --cover \
        --chapter \
        --aaxc \
        --quality normal \
        --output-dir "$DOWNLOAD_DIR" \
        --no-confirm \
        --filename-mode asin_ascii

# COnverting to MP3

aaxc_file=$(find $DOWNLOAD_DIR -name "*.aaxc")

# ./AAXtoMP3 \
#         --use-audible-cli-data \
#         --target_dir "$AUDIOBOOKS_DIR" \
#         "$aaxc_file"
u2dos ()
{
        set -f; IFS=' '; printf '%s\r\n' $(cat "$1")
}

find "$AUDIOBOOKS_DIR" -name "*.m3u" -exec  sed -i 's/\([^^M]\)$/\0^M/' {} \;
