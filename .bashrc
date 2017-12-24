echo "+===========================+"
echo "| Running .bashrc by @gendx |"
echo "+===========================+"

# ========== Detect OS ==========
case $OSTYPE in
    darwin*) { echo "MacOS detected"; OS_MAC=true; } ;;
    linux*) { echo "Linux detected"; OS_LINUX=true; } ;;
    *) echo "Unknown OS..." ;;
esac

# ========== Global definitions ==========
if [ -f /etc/bash.bashrc ]; then
    echo "Loading global definitions from \"/etc/bash.bashrc\"..."
    . /etc/bash.bashrc
fi
if [ -f /etc/bashrc ]; then
    echo "Loading global definitions from \"/etc/bashrc\"..."
    . /etc/bashrc
fi

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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# ========== Alias ==========
if [ -n "$OS_MAC" ]; then
    echo "Setting up aliases for MacOS..."
    alias ls="ls -G"
fi

if [ -n "$OS_LINUX" ]; then
    echo "Setting up aliases for Linux..."
    alias ls="ls --color=auto"
fi

echo "Setting up aliases..."
alias ll="ls -lF"
alias lla="ls -lFa"

# ========== Machine-specific ==========
if [ -f ~/.bashrc.local ]; then
    echo "Loading machine-specific definitions from \"~/.bashrc.local\"..."
    . ~/.bashrc.local
fi

