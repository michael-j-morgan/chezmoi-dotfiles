lsf() {
    ls -alph "$@" | grep -v '/$'
}

ducks() {
    if (( $# )); then
        du -ks -- "$@"
    else
        local entries=( *(N) )
        (( ${#entries} )) || return 0
        du -ks -- "${entries[@]}"
    fi | sort -rn | head
}

look() {
    local entries=( *(N) )
    (( ${#entries} )) || return 0

    find "${entries[@]}" -type f | fzf
}

search() {
    grep --color=auto -rnw ./ -e "$@"
}

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

eject-terastick() {
  osascript -e 'quit app "Ollama"'
  sleep 1
  diskutil eject "/Volumes/TeraStick"
}

notes() {
    local file

    file=$(
        find . -type d -name .git -prune -o -type f -name '*.md' -print |
        fzf \
            --preview 'glow -s dark -w $FZF_PREVIEW_COLUMNS {}' \
            --preview-window='right:60%:wrap'
    ) || return

    ${EDITOR:-nvim} "$file"
}

ditch() {
  local journal="$HOME/Documents/digital-decluttering.md"
  local trash_dir="$HOME/.Trash"
  local file answer reason timestamp
  local original_path basename target stem ext counter

  if (( $# == 0 )); then
    echo "Usage: ditch <file> [...]"
    return 1
  fi

  for file in "$@"; do
    if [[ ! -e "$file" ]]; then
      echo "Not found: $file"
      continue
    fi

    if [[ -d "$file" && "$file" != *.app ]]; then
      echo "Skipping directory: $file"
      continue
    fi

    original_path="${file:A}"

    printf "Trash '%s'? [y/N/r] " "$file"
    read -r answer

    case "$answer" in
      y|Y)
        reason="No longer needed."
        ;;

      r|R)
        printf "Reason: "
        read -r reason
        [[ -z "$reason" ]] && reason="No longer needed."
        ;;

      ""|n|N)
        echo "Kept: $file"
        continue
        ;;

      *)
        echo "Unrecognized response; keeping: $file"
        continue
        ;;
    esac

    basename="${file:t}"
    target="$trash_dir/$basename"

    #
    # Avoid overwriting an existing item in ~/.Trash.
    #
    if [[ -e "$target" ]]; then
      if [[ "$basename" == *.* ]]; then
        stem="${basename%.*}"
        ext=".${basename##*.}"
      else
        stem="$basename"
        ext=""
      fi

      counter=1

      while [[ -e "$trash_dir/${stem}-$counter${ext}" ]]; do
        (( counter++ ))
      done

      target="$trash_dir/${stem}-$counter${ext}"
    fi

    timestamp=$(date '+%Y-%m-%d %H:%M')

    if mv -- "$file" "$target"; then
      {
  	echo
  	echo "### $timestamp"
  	echo
  	echo "- **Abandoned:** \`$original_path\`"
  	echo "  - Reason: $reason"

  	if [[ "${target:t}" != "$basename" ]]; then
    	  echo "  - Trash name: \`${target:t}\`"
  	fi

  	echo
      } >> "$journal"


      echo "Trashed and journaled: $basename"
    else
      echo "Failed to move to Trash: $file"
    fi
  done
}
djournal() {
  local journal="$HOME/Documents/digital-decluttering.md"

  if [[ ! -f "$journal" ]]; then
    echo "Decluttering journal not found: $journal"
    return 1
  fi

  if command -v glow >/dev/null 2>&1; then
    glow -p "$journal"
  elif command -v bat >/dev/null 2>&1; then
    bat "$journal"
  else
    less "$journal"
  fi
}
djournal-edit() {
  ${EDITOR:-nvim} "$HOME/Documents/digital-decluttering.md"
}
