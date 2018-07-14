# ~/.bashrc: executed by bash(1) for non-login shells.

# Global

export NODE_ENV='development'
export EDITOR='emacs -nw'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

export LSCOLORS=ExFxCxDxBxegedabagacad

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

#alias myip="echo `wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'`"
alias iptable='iptables -L -v -n --line-number'
alias cd..='cd ..'
alias cd.='cd ..'
alias ..=' cd ..'
alias l='ls -alh --group-directories-first --color'
alias ll='ls -alh --group-directories-first --color'
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'
alias lll='ls -lh'
alias la='ls -Ah'
alias df='df -h'
alias ne='emacs -nw'
alias which='type -a'
alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'
alias grpe='grep'
alias mroe='more'
alias iv='vi'
alias tial='tail'
alias xs='cd'
alias vf='cd'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion.d ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

ulimit -S -c 0          # Don't want any coredumps.

# complete -A hostname   rsh rcp telnet rlogin r ftp ping disk
# complete -A export     printenv
# complete -A variable   export local readonly unset
# complete -A enabled    builtin
# complete -A alias      alias unalias
# complete -A function   function
# complete -A user       su mail finger

# complete -A helptopic  help     # Currently, same as builtins.
# complete -A shopt      shopt
# complete -A stopped -P '%' bg
# complete -A job -P '%'     fg jobs disown

# complete -A directory  mkdir rmdir
# complete -A directory   -o default cd

# # Compression
# complete -f -o default -X '*.+(zip|ZIP)'  zip
# complete -f -o default -X '!*.+(zip|ZIP)' unzip
# complete -f -o default -X '*.+(z|Z)'      compress
# complete -f -o default -X '!*.+(z|Z)'     uncompress
# complete -f -o default -X '*.+(gz|GZ)'    gzip
# complete -f -o default -X '!*.+(gz|GZ)'   gunzip
# complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
# complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
# complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|bz2|BZ2)' extract


# # Documents - Postscript,pdf,dvi.....
# complete -f -o default -X '!*.+(ps|PS)'  gs ghostview ps2pdf ps2ascii
# complete -f -o default -X '!*.+(dvi|DVI)' dvips dvipdf xdvi dviselect dvitype
# complete -f -o default -X '!*.+(pdf|PDF)' acroread pdf2ps
# complete -f -o default -X \
#     '!*.@(@(?(e)ps|?(E)PS|pdf|PDF)?(.gz|.GZ|.bz2|.BZ2|.Z))' gv ggv
# complete -f -o default -X '!*.texi*' makeinfo texi2dvi texi2html texi2pdf
# complete -f -o default -X '!*.tex' tex latex slitex
# complete -f -o default -X '!*.lyx' lyx
# complete -f -o default -X '!*.+(htm*|HTM*)' lynx html2ps
# complete -f -o default -X \
#     '!*.+(doc|DOC|xls|XLS|ppt|PPT|sx?|SX?|csv|CSV|od?|OD?|ott|OTT)' soffice

# # Multimedia
# complete -f -o default -X \
#     '!*.+(gif|GIF|jp*g|JP*G|bmp|BMP|xpm|XPM|png|PNG)' xv gimp ee gqview
# complete -f -o default -X '!*.+(mp3|MP3)' mpg123 mpg321
# complete -f -o default -X '!*.+(ogg|OGG)' ogg123
# complete -f -o default -X \
#     '!*.@(mp[23]|MP[23]|ogg|OGG|wav|WAV|pls|m3u|xm|mod|s[3t]m|it|mtm|ult|flac)' xmms
# complete -f -o default -X \
#     '!*.@(mp?(e)g|MP?(E)G|wma|avi|AVI|asf|vob|VOB|bin|dat|vcd|\
# ps|pes|fli|viv|rm|ram|yuv|mov|MOV|qt|QT|wmv|mp3|MP3|ogg|OGG|\
# ogm|OGM|mp4|MP4|wav|WAV|asx|ASX)' xine

# complete -f -o default -X '!*.pl'  perl perl5

monit()
{
    while [ /bin/true ]; do OLD=$NEW; NEW=`cat /proc/net/dev | grep $1 | tr -s ' ' | cut -d' ' -f "3 11"`; echo $NEW $OLD | awk '{printf("\rin: % 9.2g\t\tout: % 9.2g", ($1-$3)/1024, ($2-$4)/1024)}'; sleep 1; done
}

function gff() {
    git add --all .; git commit -am "$1"; git push
}

# Get public ip
function ip() {
    wget -q -O - checkip.dyndns.org|sed -e 's/.*Current IP Address: //' -e 's/<.*$//'
}

alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch -a -v'
alias gc='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias gh='cat ~/.emacs.d/bash-helpers/git-cheat'

alias pm2='/home/unitech/keymetrics/pm2/bin/pm2'
alias pm2-runtime='/home/unitech/keymetrics/pm2/bin/pm2-runtime'
alias forge='grunt-init'

alias listbig='find . -type f -size +10000k -exec ls -lh {} \'
alias xmp3='/home/unitech/sciences/xmp3/bin/xmp3'

alias conn="cat /var/lib/misc/dnsmasq.leases"
alias dockerstop='docker stop $(docker ps -a -q)'

# # enable programmable completion features (you don't need to enable
# # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# # sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
#   if [ -f /usr/share/bash-completion/bash_completion ]; then
#     . /usr/share/bash-completion/bash_completion
#   elif [ -f /etc/bash_completion ]; then
#     . /etc/bash_completion
#   fi
# fi
