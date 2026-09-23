alias cls="clear"
alias down="cd ~/Downloads"
alias ..="cd .."
alias ....="cd ../.."
alias ports="lsof -PiTCP -sTCP:LISTEN"
alias gc="git clone"
alias gch="git checkout"
alias graph="git log --color --graph --pretty=format:\"%h | %ad | %an | %s%d\" --date=short"
alias hist="git log --color --pretty=format:\"%C(yellow)%h%C(reset) %s%C(bold red)%d%C(reset) %C(green)%ad%C(reset) %C(blue)[%an]%C(reset)\" --relative-date --decorate"
alias speedtest="curl -o /dev/null cachefly.cachefly.net/100mb.test"
alias serve="python3 -m http.server 8000"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias t='todo.sh'
alias weather="curl wttr.in/ERI"
