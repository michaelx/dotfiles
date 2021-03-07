#!/usr/bin/env bash

# To maintain cask:
# brew update && brew upgrade brew-cask && brew cleanup

# To update applications that don’t update themeselves:
# brew cask upgrade

# Archiving
brew install --cask keka

# Audio

# Backup and Synchronization
brew install --cask arq
#brew install --cask borgbackup

# Burning and Ripping
#brew install --cask burn
brew install --cask handbrake
brew install --cask makemkv

# Development
brew install --cask dteoh-devdocs
brew install --cask fork
brew install --cask forklift
brew install --cask hex-fiend
brew install --cask insomnia
brew install --cask integrity
brew install --cask paw
brew install --cask react-native-debugger
# brew install --cask screaming-frog-seo-spider # Note: Use dockerized instead.
brew install --cask sublime-merge
brew install --cask sublime-text
brew install --cask tableplus
brew install --cask visual-studio-code

# Gaming
#brew install --cask dolphin
#brew install --cask enjoyable
brew install --cask openemu
brew install --cask origin
brew install --cask steam

# Image Editing
brew install --cask imagealpha
brew install --cask imageoptim

# Internet
brew install --cask discord
brew install --cask firefox-developer-edition
brew install --cask google-chrome
#brew install --cask namebench
#brew install --cask tor-browser
brew install --cask transmission
brew install --cask tunnelblick

# Misc
brew install --cask geekbench
brew install --cask google-earth-pro

# Office
#brew install --cask calibre
brew install --cask kindle
#brew install --cask libreoffice # Note: Only needed for some Pandoc workflows.
brew install --cask licecap
brew install --cask macdown
brew install --cask marked
#brew install --cask netnewswire
brew install --cask scapple
brew install --cask terminology
brew install --cask obsidian

# Productivity
brew install --cask bitwarden
brew install --cask hammerspoon
brew install --cask hazel
brew install --cask iterm2
brew install --cask keyboard-maestro

# Services and Scripts
brew install --cask omnidisksweeper

# (UI) Design
brew install --cask colorpicker-skalacolor
brew install --cask figma
brew install --cask glueprint
brew install --cask sketch

# Video
#brew install --cask plex-media-server
brew install --cask iina
brew install --cask vlc

# Virtualize
# Note: Use dev server instead. No third-party kexts on main machine!
#brew install --cask virtualbox


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
# Reeder (switch to https://github.com/brentsimmons/NetNewsWire once it has Fever sync support)
# Wipr
# Xcode (or CLI: xcode-select --install)
