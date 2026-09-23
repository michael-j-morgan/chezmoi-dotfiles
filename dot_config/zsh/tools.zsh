export NVM_DIR="${NVM_DIR:-$HOME/.nvm}"

_nvm_lazy_load() {
    [[ -n "${_NVM_LAZY_LOADED:-}" ]] && return 0
    [[ -s /opt/homebrew/opt/nvm/nvm.sh ]] || return 1

    builtin source /opt/homebrew/opt/nvm/nvm.sh --no-use || return
    _NVM_LAZY_LOADED=1
}

nvm() {
    _nvm_lazy_load || return
    nvm "$@"
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
. /opt/homebrew/etc/profile.d/z.sh
