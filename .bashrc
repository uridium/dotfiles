export EDITOR='vim'
export GIT_PS1_SHOWDIRTYSTATE=true          # unstaged (*), staged (+)
export GIT_PS1_SHOWSTASHSTATE=true          # stashed ($)
export GIT_PS1_SHOWUNTRACKEDFILES=true      # untracked (%)
export GREP_COLOR='1;36;36'
export HISTSIZE='1000'
export HISTFILESIZE='1000'
export HISTTIMEFORMAT='%Y%m%d %T   '
export HISTCONTROL='ignoreboth:erasedups'
export LESS_TERMCAP_md=$'\E[01;31m'         # Start bold mode
export LESS_TERMCAP_me=$'\E[0m'             # End all mode like so, us, mb, md and mr
export LESS_TERMCAP_ue=$'\E[0m'             # End underlining
export LESS_TERMCAP_us=$'\E[01;32m'         # Start underlining
export LS_OPTIONS='--color=auto --hide-control-chars --classify'
export PROMPT_COMMAND='echo $USER "$(history 1)" >>~/.bash_eternal_history/.bash_eternal_history-$(date +%Y%m)'
export PS1='\[\e[1;38;5;39m\]$(__git_ps1 "(%s) " 2>/dev/null)\[\e[1;38;5;40m\][ \t ] \[\e[1;38;5;178m\]\H:\[\e[1;38;5;40m\]\w\[\e[1;38;5;178m\]\$ \[\e[0m\]'
export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")

### standard aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cal='cal -3'
alias cp='cp -i'
alias df='df -Th'
alias diff='colordiff -u'
alias exip='curl ifconfig.co'
alias g='git'
alias grep='LANG=C grep --color=auto'
alias gerp='LANG=C grep --color=auto'
alias ini='cd /etc/init.d'
alias l='ls -lA --time-style="+%Y%m%d %H:%M:%S" $LS_OPTIONS'
alias ll='ls -l --time-style="+%Y%m%d %H:%M:%S" $LS_OPTIONS'
alias ls='ls $LS_OPTIONS'
alias less='less -i -R -P "?f %f: Standard input. | .?m(file %i of %m) | .?ltlines\: %lt-%lb?L/%L. | .bytes\: %bB?s/%s. | ?e(END) :?pB%pB\%..%t"'
alias man='LC_ALL=C man'
alias mv='mv -i'
alias n='netstat -punta'
alias ne='netstat -punta | grep ESTABLISHED'
alias nls='netstat -puntl'
alias nlsg='netstat -puntl | grep $1'
alias ps='ps --headers af -eo "user:16 pid %cpu %mem nice stat lstart:32 etime:16 nlwp args"'
alias rm='rm -i'
alias scp='scp -o ConnectTimeout=10'
alias screen='LC_ALL=C screen'
alias ssh='ssh -o ConnectTimeout=10 -o HashKnownHosts=no -o ForwardAgent=yes -o ServerAliveInterval=60'
alias sudo='sudo '
alias sd='sudo -Es'
alias tcpdump='tcpdump -s0 -nnv'
alias tree='tree -pugalhCD'
alias v='vim'
alias vcp='vcp -i'
### debian aliases
alias ac='apt-cache'
alias acp='apt-cache policy'
alias acsh='apt-cache show'
alias af='apt-file'
alias afl='apt-file list'
alias afs='apt-file search'
alias ag='apt-get'
alias agi='apt-get -V install'
alias agrp='apt-get -V remove --purge'
alias agap='apt-get -V autoremove --purge'
alias agclean='apt-get -V remove --purge $(ls /var/cache/apt/archives | grep ".deb" | cut -d "_" -f 1)'

# wylaczamy powiadomienia o mailach
shopt -u mailwarn
unset MAILCHECK

# creating bash eternal history
if [ ! -d $HOME/.bash_eternal_history ]; then
    install -m 700 -d $HOME/.bash_eternal_history
fi

# creating bash history
if [ ! -e $HOME/.bash_history ]; then
    touch $HOME/.bash_history
    chmod 600 $HOME/.bash_history
fi

# creating less history
if [ ! -e $HOME/.lesshst ]; then
    touch $HOME/.lesshst
    chmod 600 $HOME/.lesshst
fi

# creating viminfo
if [ ! -e $HOME/.viminfo ]; then
    touch $HOME/.viminfo
    chmod 600 $HOME/.viminfo
fi

# creating hushlogin
if [ ! -e $HOME/.hushlogin ]; then
    touch $HOME/.hushlogin
fi

# reading bash local settings
if [ -e $HOME/.bashrc_local ]; then
    . $HOME/.bashrc_local
fi

# reading bash completion
if [ -e /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# terminal colors
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# unmap ctrl+s
if [ -t 0 ]; then
    stty stop undef
fi

# generowanie hasla,
# jesli nie podamy dlugosci hasla (np. genp 16), zwrocone zostanie 8 znakowe
function genp() {
    tr -dc 'A-Za-z0-9' </dev/urandom | head -c ${1:-8} | xargs
}

# posortowane wyszukiwanie pakietow
function acs() {
    apt-cache search $1 | sort
}

# przeszukiwanie eternal history
function eh() {
    grep -i -h $1 $HOME/.bash_eternal_history/.bash*
}
