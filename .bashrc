export EDITOR='vim'
export GIT_PS1_SHOWDIRTYSTATE=true          # unstaged (*), staged (+)
export GIT_PS1_SHOWSTASHSTATE=true          # stashed ($)
export GIT_PS1_SHOWUNTRACKEDFILES=true      # untracked (%)
export GREP_COLORS='ms=01;34:mc=01;34:sl=:cx=:fn=35:ln=32:bn=32:se=36'
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
export PS1='\[\e[1;38;5;15m\][ \t ] \[\e[1;38;5;88m\]$(__awsenv_ps1 2>/dev/null)\[\e[1;38;5;242m\]\H:\[\e[1;38;5;15m\]\w\[\e[1;38;5;242m\]$(__git_ps1 2>/dev/null)\[\e[1;38;5;15m\] \$ \[\e[0m\]'
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

alias ..='cd ..'
alias ...='cd ../..'
alias cal='cal -3'
alias cp='cp -i'
alias df='df -Th'
alias diff='colordiff -u'
alias exip='curl ifconfig.io'
alias fiso='find -type f -not -ipath "./.git/*" -printf "%M %u %g    %TY%Tm%Td %TH:%TM:%.2TS  %p\n" | sort -k4'
alias gitk='gitk --all'
alias grep='LANG=C grep -O --recursive --no-messages --color=auto --exclude-dir=.git --exclude-dir=.terraform --exclude=*.tfstate.backup --exclude=*.swp'
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
alias pwgen='pwgen -s 10 1 | xclip -f'
alias rm='rm -i'
alias screen='LC_ALL=C screen'
alias sudo='sudo '
alias sd='sudo -Es'
alias tcpdump='tcpdump -s0 -nnv'
alias tree='tree -pugalhCD --timefmt "%Y%m%d %H:%M:%S"'
alias v='vim'
alias vr='vim -R'

# debian specific
alias ac='apt-cache'
alias acp='apt-cache policy'
alias acsh='apt-cache show'
alias af='apt-file'
alias afl='apt-file list'
alias afs='apt-file search'
alias ag='apt-get'
alias agi='apt-get -V install'
alias agu='apt-get update && apt-get -V dist-upgrade'
alias agrp='apt-get -V remove --purge'
alias agap='apt-get -V autoremove --purge'
alias agclean='apt-get -V remove --purge $(ls /var/cache/apt/archives | grep ".deb" | cut -d "_" -f 1)'

# aws specific
alias aws-ami-id="curl -w '\n' http://169.254.169.254/latest/meta-data/ami-id"
alias aws-instance-id="curl -w '\n' http://169.254.169.254/latest/meta-data/instance-id"
alias aws-instance-type="curl -w '\n' http://169.254.169.254/latest/meta-data/instance-type"
alias aws-local-ipv4="curl -w '\n' http://169.254.169.254/latest/meta-data/local-ipv4"
alias aws-public-ipv4="curl -w '\n' http://169.254.169.254/latest/meta-data/public-ipv4"
alias aws-security-groups="curl -w '\n' http://169.254.169.254/latest/meta-data/security-groups"
alias aws-user-data="curl -w '\n' http://169.254.169.254/latest/user-data"

# autocomplete
complete -C aws_completer aws
complete -C terraform terraform
# include
source $HOME/.bashrc_* 2>/dev/null

# turning off email info
shopt -u mailwarn
unset MAILCHECK

# sorting packages
function acs() {
    apt-cache search $1 | sort
}

# combing through eternal history
function eh() {
    grep -i -h $@ $HOME/.bash_eternal_history/.bash*
}

# ruby apps
if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
fi

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
    source $HOME/.bashrc_local
fi

# reading bash completion
if [ -e /etc/bash_completion ]; then
    source  /etc/bash_completion
fi

# unmap ctrl+s
if [ -t 0 ]; then
    stty stop undef
fi
