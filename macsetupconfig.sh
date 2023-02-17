#!/bin/sh

# Introduction
echo "Nice to meet you there :) I see you are setting up a new mac! "

echo "Close any open System Preferences panes, to prevent them from overriding settings we are about to change"
osascript -e 'tell application "System Preferences" to quit'

echo "Let's get started!"

# Ask for administrator password to run script
echo " Ask for the administrator/root password for the duration of this script"
sudo -v

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

echo "Now running Safari & Webkit commands"

# Show the full URL in the address bar (note: this still hides the scheme)
echo "Show the full URL in the address bar"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Privacy: don’t send search queries to Apple
echo "Privacy: do not send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Set Safari’s home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Warn about fraudulent websites
echo "Warn about fraudulent websites"
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Enable “Do Not Track”
echo "Enable DO NOT TRACK"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

echo "Now running Finder commands"

# Show all filename extensions in Finder
echo " Finder: show all filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

echo " Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Save to disk (not to iCloud) by default
echo " Finder: Save to Mac, instead of iCloud by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo " Enable snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
echo "Set Desktop as the default location for new Finder windows"
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show icons for hard drives, servers, and removable media on the desktop
echo "Show icons for hard drives, servers, and removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show path bar
echo "Finder: show path bar"
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
echo "Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Change minimize/maximize window effect
echo "Change minimize/maximize window effect"
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
echo "Minimize windows into their applications icon"
defaults write com.apple.dock minimize-to-application -bool true

# Speed up Mission Control animations
echo "Speed up Mission Control animations"
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t show recent applications in Dock
echo "Do not show recent applications in Dock"
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Terminal, TextEdit & QuickTime Player                                       #
###############################################################################

echo "Now running Terminal/TextEdit/QuickTime Player Commands"

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.terminal SecureKeyboardEntry -bool true

# Use plain text mode for new TextEdit documents
echo "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0

# Open and save files as UTF-8 in TextEdit
echo "Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Auto-play videos when opened with QuickTime Player
echo "Auto-play videos when opened with QuickTime Player"
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

###############################################################################
# Activity Monitor                                                            #
###############################################################################

echo "Now running Activity Monitor Commands"

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# Disk Utility                                                                #
###############################################################################

echo "Now running Disk Utility commands"

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true


###############################################################################
# Energy Saving                                                               #
###############################################################################

echo "Now running Energy Saving Commands"

# Enable lid wakeup
sudo pmset -a lidwake 1

# Sleep the display after 15 minutes
sudo pmset -a displaysleep 15

###############################################################################
# Trackpad & Keyboard                                                         #
###############################################################################

echo " Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set a blazingly fast keyboard repeat rate
echo "Set a blazingly fast keyboard repeat rate"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

echo " Automatically illuminate built-in MacBook keyboard in low light"
defaults write com.apple.BezelServices kDim -bool true

echo " Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
echo "Require password immediately after sleep or screen saver begin"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
echo "Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
echo "Save screenshots in PNG format"
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
echo "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the automatic update check
echo "Enable the automatic update check"
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for software updates daily, not just once per week
echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
echo "Download newly available updates in background"
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
echo "Install System data files & security updates"
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn on app auto-update
echo "Turn on app auto-update"
defaults write com.apple.commerce AutoUpdate -bool true

###############################################################################
# SSH, Firewall and Networking                                                #
###############################################################################

echo "Now running Networking Commands"

# Enable Screen Sharing
sudo defaults write /var/db/launchd.db/com.apple.launchd/overrides.plist com.apple.screensharing -dict Disabled -bool false
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist

###############################################################################
# Install Packages                                                            #
###############################################################################

echo "Now Installing Packages"

echo "Installing Rosetta"
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

echo "Installing XCode Command Line Tools"
xcode-select --install

echo "Installing Zoom"
curl -L -O https://zoom.us/client/latest/ZoomInstallerIT.pkg

echo "Installing Sophos Central"
curl -L -O https://dzr-api-amzn-us-west-2-fa88.api-upe.p.hmr.sophos.com/api/download/4b2d7ff952ba817680551198cfd2552f/SophosSetup.exe

echo "Installing Visual Studio Code"
curl -L -O hhttps://code.visualstudio.com/sha/download?build=stable&os=darwin-arm64


echo "Installing Google Chrome"
curl -L -O https://dl.google.com/chrome/mac/stable/accept_tos%3Dhttps%253A%252F%252Fwww.google.com%252Fintl%252Fen_ph%252Fchrome%252Fterms%252F%26_and_accept_tos%3Dhttps%253A%252F%252Fpolicies.google.com%252Fterms/googlechrome.pkg

echo "Installing Mozilla Firefox"
curl -L -O https://download.mozilla.org/?product=firefox-latest-ssl&os=osx&lang=en-US

echo "Installing Rectangle"
curl -L -O https://github.com/rxhanson/Rectangle/releases/download/v0.65/Rectangle0.65.dmg

echo "Installing DisplayLink Manager"
curl -L -O https://sgcdn.startech.com/005329/media/sets/displaylink_mac_drivers/%5bdisplaylink%5d%20mac%20usb%20display%20adapter.zip
unzip %5bdisplaylink%5d%20mac%20usb%20display%20adapter.zip

echo "Installing Microsoft Remote Desktop"
curl -L -O https://go.microsoft.com/fwlink/?linkid=868963&WT.mc_id=DT-MVP-5003202

echo "Installing Boop"
curl -L -O https://github.com/IvanMathy/Boop/releases/download/1.4.0/Boop.zip
unzip Boop.zip

echo "Installing Microsoft Teams"
curl -L -O https://go.microsoft.com/fwlink/p/?LinkID=869428&clcid=0x409&culture=en-us&country=US&lm=deeplink&lmsrc=groupChatMarketingPageWeb&cmpid=directDownloadMac

sudo installer -pkg "/Users/admin/Desktop/ZoomInstallerIT.pkg" -target /
sudo installer -pkg "/Users/admin/Desktop/googlechrome.pkg" -target /
sudo installer  -allowUntrusted -dmg "/Users/admin/Desktop/Rectangle0.65.dmg" -target /
sudo installer -pkg "/Users/admin/Desktop/[displaylink] mac usb display adapter/DisplayLink Manager Graphics Connectivity 1.4.pkg" -target /
sudo mv "/Users/admin/Desktop/Boop,app" "/User/admin/Applications/Boop,app"

###############################################################################
# Final Verification                                                          #
###############################################################################

echo "Final verification"
# Get Server IP Address; network config for en0
ipconfig getifaddr en0

# View system info
sw_vers
uname -a
uptime

# Reboot the system
echo "Well that was fun, wasn't it? I hope everything worked as it should :) "
echo "Note that some of these changes require a logout/restart to take effect."
echo "So, please _/\_ restart your mac!"
exec "$SHELL"
