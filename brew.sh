#!/usr/bin/env bash

# Update the formulae and Homebrew itself
brew update

# Upgrade everything already installed
brew upgrade

# Install main GNU packages
brew install coreutils
brew install findutils
brew install moreutils

# Install other useful GNU packages
brew install autoconf
brew install automake
brew install gnu-sed
brew install gnupg
brew install grep
brew install libtool
brew install readline
brew install screen
brew install wget --with-iri

# Install other useful packages
#brew install ack
#brew install asdf # Use git clone install for now.
#brew install ddclient
brew install ffmpeg
brew install ghostscript
brew install git
brew install git-lfs
brew install graphicsmagick
brew install heroku
brew install htop
brew install imagemagick --with-webp
brew install jdupes
#brew install libvpx # When webm is needed
brew install libxslt
brew install libyaml
#brew install lua
brew install openssh
brew install openssl
brew install pandoc
#brew install postgresql
brew install rename
#brew install rlwrap
brew install rsync
brew install ruby-build
brew install sqlite
brew install ssh-copy-id
brew install tree
#brew install tvnamer
brew install unixodbc # Driver for sql servers, used by asdf plugins
brew install vim --with-override-system-vi
brew install webkit2png
brew install xz
brew install yarn
brew install youtube-dl
brew install zsh
brew install zsh-completions

# Uninstall old versions
brew cleanup
