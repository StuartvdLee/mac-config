# Remove all items from Dock and set the icon size to 48
defaults write "com.apple.dock" "persistent-apps" -array; killall Dock
defaults write com.apple.dock tilesize -int 48; killall Dock
echo "Dock setup done"

# Disable Spotlight and Finder search hotkeys
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '{enabled = 0; value = { parameters = (32, 49, 1048576); type = "standard"; }; }'
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 65 '{enabled = 0; value = { parameters = (32, 49, 1572864); type = "standard"; }; }'
killall SystemUIServer
echo "Disabled Spotlight and Finder search hotkeys"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "Successfully installed Homebrew"

# Install apps from app-list.txt
xargs brew install < app-list.txt
echo "Successfully installed apps"

# Add Raycast to login items
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Raycast.app", hidden:true}'
echo "Added Raycast to login items"

# git config
git config --global user.name "Stuart van der Lee"
git config --global user.email [FILL IN YOUR EMAIL]
git config --global push.default "current"
git config --global push.autoSetupRemote true
git config --global pull.rebase false
git config --global fetch.prune true
git config --global core.editor "code"
git config --global init.defaultBranch "main"
echo "Git config done"
