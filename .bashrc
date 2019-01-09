# ========== Greeting ==========

CLR="\\033[0m"
RED="\\033[0;31m"
GRN="\\033[0;32m"
YEL="\\033[0;33m"
echo -e "${YEL}+===========================+${CLR}"
echo -e "${YEL}| ${GRN}Running .bashrc by ${RED}@gendx ${YEL}|${CLR}"
echo -e "${YEL}+===========================+${CLR}"
unset CLR RED GRN YEL

# ========== Detect OS ==========

OS_MAC=false
OS_LINUX=false
case $OSTYPE in
    darwin*) { echo "MacOS detected"; OS_MAC=true; } ;;
    linux*) { echo "Linux detected"; OS_LINUX=true; } ;;
    *) echo "Unknown OS..." ;;
esac

# ========== Global definitions ==========

if [ -f /etc/bash.bashrc ]; then
    echo "Loading global definitions from \"/etc/bash.bashrc\"..."
    source /etc/bash.bashrc
fi
if [ -f /etc/bashrc ]; then
    echo "Loading global definitions from \"/etc/bashrc\"..."
    source /etc/bashrc
fi

# TODO: move this line at the top?
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ========== History ==========

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# ========== Prompt ==========

function returncode
{
    returncode=$?
    if [ $returncode != 0 ]; then
        echo "[$returncode]"
    else
        echo ""
    fi
}

USE_COLOR=true

if ${USE_COLOR} ; then
    PS1='\[\033[0;31m\]$(returncode)\[\033[0;37m\]\[\033[0;35m\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;34m\] @ \[\033[0;33m\]\h\[\033[01;34m\] \w \$\[\033[00m\] '
else
    PS1='\[$(returncode)\]\u @ \h \w \$ '
fi

# ========== Editor ==========

echo "Setting up EDITOR and VISUAL env (exported to subprocesses)..."
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

# ========== Alias ==========

if ${OS_MAC} ; then
    echo "Setting up aliases for MacOS..."
    alias ls="ls -G"
fi

if ${OS_LINUX} ; then
    echo "Setting up aliases for Linux..."
    alias ls="ls --color=auto"
fi

echo "Setting up aliases..."
alias ll="ls -lF"
alias lla="ls -lFa"
alias tree="tree -C"
alias less="/usr/bin/less" # No gunzip and other pdftotext thanks!
alias lessclr="less -R" # Show colors
alias gdiff="git diff --no-index --color-words"

# ========== Cool functions ==========

# Dirty hack but useful to decompress raw zlib streams
if hash gzip &>/dev/null ; then
    unzlib() {
        printf "\\x1f\\x8b\\x08\\x00\\x00\\x00\\x00\\x00" | cat - "$@" | gzip -dc
    }
fi

# ========== Clean up ==========

unset OS_MAC OS_LINUX

# ========== Machine-specific ==========

if [ -f ~/.bashrc.local ]; then
    echo "Loading machine-specific definitions from \"~/.bashrc.local\"..."
    source ~/.bashrc.local
fi

