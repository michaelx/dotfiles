# Path to oh-my-zsh
export ZSH=/Users/michael/.oh-my-zsh

# Theme
ZSH_THEME="dracula"

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins to load
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git zsh-nvm osx compleat sublime)

source $ZSH/oh-my-zsh.sh


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Language environment (fixes Pi problems)
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"


# MX env

# Load rbenv
eval "$(rbenv init -)"

# Add Homebrew to $PATH
export PATH=/usr/local/sbin:$PATH