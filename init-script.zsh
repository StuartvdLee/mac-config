# Remove all items from Dock and set the icon size to 48
defaults write "com.apple.dock" "persistent-apps" -array; killall Dock
defaults write com.apple.dock tilesize -int 48; killall Dock

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

xargs brew install < brew-list.txt