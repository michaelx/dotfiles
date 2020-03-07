#!/usr/bin/env bash

# To maintain cask:
# brew update && brew upgrade brew-cask && brew cleanup

# To update applications that don’t update themeselves:
# brew cask upgrade

# Archiving
brew cask install keka

# Audio

# Backup and Synchronization
brew cask install arq
#brew cask install borgbackup

# Burning and Ripping
#brew cask install burn
brew cask install handbrake
brew cask install makemkv

# Development
brew cask install forklift
brew cask install hex-fiend
brew cask install integrity
brew cask install paw
brew cask install postico
brew cask install postman
brew cask install screaming-frog-seo-spider
brew cask install sequel-pro
brew cask install sourcetree
brew cask install sublime-merge
brew cask install sublime-text
brew cask install visual-studio-code

# Gaming
#brew cask install dolphin
#brew cask install enjoyable
brew cask install openemu
brew cask install origin
brew cask install steam

# Image Editing
brew cask install imagealpha
brew cask install imageoptim

# Internet
brew cask install firefox-developer-edition
brew cask install google-chrome
#brew cask install namebench
#brew cask install tor-browser
brew cask install transmission
brew cask install tunnelblick

# Misc
brew cask install geekbench
brew cask install google-earth-pro

# Office
#brew cask install calibre
brew cask install kindle
#brew cask install libreoffice # Note: Only needed for some Pandoc workflows.
brew cask install licecap
brew cask install macdown
brew cask install marked
brew cask install netnewswire
brew cask install scapple
brew cask install terminology

# Productivity
brew cask install bitwarden
brew cask install hammerspoon
brew cask install hazel
brew cask install iterm2
brew cask install keyboard-maestro

# Services and Scripts
brew cask install omnidisksweeper

# (UI) Design
brew cask install colorpicker-skalacolor
brew cask install glueprint
brew cask install sketch

# Video
#brew cask install plex-media-server
brew cask install iina
brew cask install vlc

# Virtualize
# Note: Use dev server instead. No third-party kexts on main machine!
#brew cask install virtualbox


# Not on cask but I want regardless

# Affinity Photo
# Calca
# (Day One)
# (Express Talk VoIP)
# iTunes
# JSON Helper for AppleScript
# Keynote
# Numbers
# Pages
# ReadKit (switch to https://github.com/brentsimmons/NetNewsWire once it has Fever sync support)
# Tweetbot
# Wipr
# Xcode (or: xcode-select --install)
