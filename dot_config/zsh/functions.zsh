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
