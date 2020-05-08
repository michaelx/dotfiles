# Path to oh-my-zsh
export ZSH=/Users/michael/.oh-my-zsh

# Theme
ZSH_THEME=dracula

# Language environment
export LANG=en_US.UTF-8

# Disable marking untracked files under VCS as dirty.
# This makes repository status check for large repositories much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins to load
plugins=(git zsh-completions)
# macOS
plugins+=(osx sublime)
# Custom plugins (~/.oh-my-zsh/custom/plugins/)
plugins+=(zsh-autosuggestions)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Add Homebrew to $PATH
export PATH=/usr/local/sbin:$PATH

# Add "g" prefixed utilities to $PATH
#
# Homebrew installs commands also provided by macOS with the prefix "g". To use
# the commands with their normal names, add the directories to the PATH, or add
# aliases for them, e.g. `alias sed=gsed`.
#export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

# Load asdf
source $HOME/.asdf/asdf.sh

# Add asdf completions to fpath, and init
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit
