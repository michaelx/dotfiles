# Project aliases
alias p="cd ~/Projects"
alias mmr="cd ~/Projects/MMR/mmr-web-v3"
alias mx="cd ~/Projects/MX/mx-web-v5"

# tmux sessions
alias tmux-default="tmux attach -t default || tmux new -s default"

# Show history
alias h="history"

# Get week number
alias week="date +%V"

# Get macOS Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
alias update="sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; sudo gem cleanup"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Show active network interfaces
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Flush Directory Service cache
alias flush="sudo killall -HUP mDNSResponder"

# Clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# macOS has no `md5sum`, so use `md5` as a fallback
command -v md5sum > /dev/null || alias md5sum="md5"

# macOS has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Empty the Trash on all mounted volumes and the main HDD.
# Also, clear Apple’s System Logs to improve shell startup speed.
# Finally, clear download history from quarantine. https://mths.be/bum
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# URL-encode strings
alias urlencode="python -c 'import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);'"

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf="/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py"

# Spotlight (disable/enable)
alias spotoff="sudo mdutil -a -i off"
alias spoton="sudo mdutil -a -i on"

# Intuitive map function
# For example, to list all directories that contain a certain file:
# find . -name .gitattributes | map dirname
alias map="xargs -n1"

# Lock the screen (when going AFK)
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# Put display to sleep
alias sleepdisplay="pmset displaysleepnow"

# Open a Finder window to the current location in the shell
alias f="open -a Finder ./"

# Test internet speed
alias speedtest="wget -O /dev/null http://speedtest.wdc01.softlayer.com/downloads/test10.zip"

# CPU / Mem usage
alias cpu="htop -s PERCENT_CPU"
alias mem="htop -s PERCENT_MEM"

# Force Time Machine Backup
alias tmbackup="/usr/bin/tmutil startbackup"

# Change DNS server
alias dns="sh ~/Projects/Scripts/dns.sh"

# Aliases for "g" prefixed utilities
#
# Homebrew installs commands also provided by macOS with the prefix "g". To use
# the commands with their normal names, add the directories to the PATH, or add
# aliases for them, e.g. `alias sed=gsed`.
#alias sed=gsed

# Open notes collection
alias notes="subl --project ~/Documents/Notes/Notes.sublime-project"

# CLI replacements
alias cat="bat"
alias top="htop"
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

# fzf
alias preview="fzf --preview 'bat --color \"always\" {}'"

# add support for ctrl+o to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# Raspberry Pi
alias pitemp="vcgencmd measure_temp"
alias picpuspeed="watch -n 1 vcgencmd measure_clock arm"
