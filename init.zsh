# Variables
PLIST="$HOME/Library/Preferences/com.apple.symbolichotkeys.plist"

# Functions
disable_hotkey() {
    local idx="$1"
    local third_mask="$2"

    echo "Disabling hotkey with index $idx..."

    /usr/libexec/PlistBuddy "$PLIST" -c "Delete :AppleSymbolicHotKeys:$idx" 2>/dev/null || true
    /usr/libexec/PlistBuddy "$PLIST" -c "Add :AppleSymbolicHotKeys:$idx:\enabled bool false"
    /usr/libexec/PlistBuddy "$PLIST" -c "Add :AppleSymbolicHotKeys:$idx:value:parameters array"
    /usr/libexec/PlistBuddy "$PLIST" -c "Add :AppleSymbolicHotKeys:$idx:value:parameters: integer 65535"
    /usr/libexec/PlistBuddy "$PLIST" -c "Add :AppleSymbolicHotKeys:$idx:value:parameters: integer 49"
    /usr/libexec/PlistBuddy "$PLIST" -c "Add :AppleSymbolicHotKeys:$idx:value:parameters: integer $third_mask"
    /usr/libexec/PlistBuddy "$PLIST" -c "Add :AppleSymbolicHotKeys:$idx:value:type string standard"

    /usr/libexec/PlistBuddy "$PLIST" -c "Print :AppleSymbolicHotKeys:$idx"
}

# Remove all items from Dock and set the icon size to 48
defaults write "com.apple.dock" "persistent-apps" -array; killall Dock
defaults write com.apple.dock tilesize -int 48; killall Dock
echo "✅ Dock setup done"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "✅ Successfully installed Homebrew"

# Install apps from app-list.txt
xargs brew install < apps.txt
echo "✅ Successfully installed apps"

# Add Raycast to login items
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Raycast.app", hidden:true}' >/dev/null
if [ $? -eq 0 ]; then
    echo "✅ Added Raycast to login items"
else
    echo "❌ Failed to add Raycast to login items" >&2
fi

# Add AlDente to login items
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/AlDente.app", hidden:true}' >/dev/null
if [ $? -eq 0 ]; then
    echo "✅ Added AlDente to login items"
else
    echo "❌ Failed to add AlDente to login items" >&2
fi

# Disable Spotlight search keyboard shortcut (Index 64, mask 1048576 = Command+Space)
disable_hotkey 64 1048576

# Disable Finder search window keyboard shortcut (Index 65, mask 1572864 = Command+Option+Space)
disable_hotkey 65 1572864

# Force cfprefsd to reload the updated plist
sudo killall cfprefsd
# Restart SystemUIServer so the menu bar will pick up new settings
killall SystemUIServer
# Immediately bind the new hotkey list in memory
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

echo "✅ Disabled Spotlight and Finder search hotkeys"
