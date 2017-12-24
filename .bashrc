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

