#!/usr/bin/env bash
#
# Download a file from Google Drive by its file ID or share URL.
#
# Usage:
#   ./gdrive_download.sh <FILE_ID_OR_URL> <OUTPUT_PATH>
#
# Examples:
#   ./gdrive_download.sh 1A2B3C4D5E6F7G8H9I output.zip
#   ./gdrive_download.sh "https://drive.google.com/file/d/1A2B3C4D5E6F7G8H9I/view?usp=sharing" output.zip

set -euo pipefail

usage() {
    echo "Usage: $0 <FILE_ID_OR_URL> <OUTPUT_PATH>" >&2
    exit 1
}

[ $# -eq 2 ] || usage

INPUT="$1"
OUTPUT="$2"

# Extract the file ID whether the user passed a raw ID or a full share URL.
extract_id() {
    local input="$1"
    if [[ "$input" =~ /d/([a-zA-Z0-9_-]+) ]]; then
        echo "${BASH_REMATCH[1]}"
    elif [[ "$input" =~ id=([a-zA-Z0-9_-]+) ]]; then
        echo "${BASH_REMATCH[1]}"
    else
        echo "$input"
    fi
}

FILE_ID="$(extract_id "$INPUT")"

COOKIE_JAR="$(mktemp)"
trap 'rm -f "$COOKIE_JAR"' EXIT

BASE_URL="https://drive.usercontent.google.com/download"

# First request: get confirmation token (needed for large files that trigger
# the "can't scan for viruses" warning).
CONFIRM_PAGE="$(curl -sc "$COOKIE_JAR" -L "${BASE_URL}?id=${FILE_ID}&export=download")"

CONFIRM_TOKEN="$(echo "$CONFIRM_PAGE" | grep -o 'confirm=[a-zA-Z0-9_-]*' | head -1 | cut -d= -f2 || true)"

if [ -n "${CONFIRM_TOKEN:-}" ]; then
    curl -Lb "$COOKIE_JAR" -o "$OUTPUT" \
        "${BASE_URL}?id=${FILE_ID}&export=download&confirm=${CONFIRM_TOKEN}"
else
    curl -Lb "$COOKIE_JAR" -o "$OUTPUT" \
        "${BASE_URL}?id=${FILE_ID}&export=download"
fi

echo "Downloaded to $OUTPUT"
