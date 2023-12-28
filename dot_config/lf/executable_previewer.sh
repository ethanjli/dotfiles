#!/usr/bin/env sh

get_tmpfile() {
  if has mktemp; then
    printf "%s%s" "$(mktemp)" "$1"
  else
    # No really good options here--let's pick a default + hope
    printf "/tmp/lfpreview-%s%s" "$(date +%s)" "$1"
  fi
}

file_path="$1"
lowercased="$(echo "$file_path" | tr '[:upper:]' '[:lower:]')"
mimetype="$(file -Lb --mime-type -- "$file_path")"


preview_plain_text() {
  bat --color always --style plain --paging=never --tabs 2 \
    "$1"
}

preview_image() {
  if [[ $ZELLIJ == "0" ]]; then
    format="--format symbols" # In Zellij, the sixel format doesn't display for some reason
  fi
  chafa $format -s "$2x$3" --animate off --polite on "$1"
}

case "$mimetype" in
  image/*)
    case "$mimetype" in
      image/svg+xml)
        thumbnail="$(get_tmpfile ".png")"
        convert "$file_path" "$thumbnail"
        preview_image "$thumbnail" "$2" "$3"
        ;;
      *)
        preview_image "$file_path" "$2" "$3"
        ;;
    esac
    exit 1
    ;;
  text/* | application/json | application/yaml)
    case "$mimetype" in
      text/plain)
        case "$lowercased" in
          *.md)
            glow -s dark "$1"
            ;;
          *)
            preview_plain_text "$file_path"
            ;;
        esac
        ;;
      *)
        preview_plain_text "$file_path"
        ;;
    esac
    ;;
  video/*)
    thumbnail="$(get_tmpfile ".png")"
    ffmpeg -y -i "$file_path" -vframes 1 "$thumbnail"
    preview_image "$thumbnail" "$@"
    ;;
  *)
    case "$lowercased" in
      *.tar | *.zip | *.7z | *.gz | *.xz | *.lzma | *.bz | *.bz2 | *.lz4 | *.sz | *.zst | *.rar)
        ouch list -t "$1"
        ;;
      *)
        echo "Unknown file type: $mimetype"
        preview_plain_text "$file_path"
        ;;
    esac
    ;;
esac
