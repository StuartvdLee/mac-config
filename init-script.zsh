# Remove all items from Dock and set the icon size to 48
defaults write "com.apple.dock" "persistent-apps" -array; killall Dock
defaults write com.apple.dock tilesize -int 48; killall Dock
print "Dock setup done"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

xargs brew install < app-list.txt

# git config
git config --global user.name "Stuart van der Lee"
git config --global user.email [FILL IN YOUR EMAIL]
git config --global push.default "current"
git config --global push.autoSetupRemote true
git config --global pull.rebase false
git config --global fetch.prune true
git config --global core.editor "code"
git config --global init.defaultBranch "main"
print "Git config done"