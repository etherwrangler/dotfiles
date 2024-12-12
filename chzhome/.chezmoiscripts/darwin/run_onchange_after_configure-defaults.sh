#!/bin/bash

set -eufo pipefail

# Dock Settings
defaults write com.apple.dock "tilesize" -int "48"
defaults write com.apple.dock "show-recents" -bool "false"

# Screenshot Settings
defaults write com.apple.screencapture "location" -string "~/Documents/Screenshots"

# Finder Settings
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true" # Not working right in Sequoia
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"
defaults write com.apple.finder "_FXSortFoldersFirst" -bool "true"
defaults write com.apple.finder "FXDefaultSearchScope" -string "SCcf"
defaults write com.apple.finder "NewWindowTarget" -string "PfVo"
defaults write com.apple.finder "NewWindowTargetPath" -string "file:///"
defaults write com.apple.finder "ShowRecentTags" -bool "false"
defaults write com.apple.finder "SidebarTagsSctionDisclosedState" -bool "true"

# Desktop Settings
defaults write com.apple.finder "ShowRemovableMediaOnDesktop" -bool "false"
defaults write com.apple.finder "ShowExternalHardDrivesOnDesktop" -bool "false"

# Misc
defaults write -g AppleInterfaceStyle Dark # Sets Interface to Dark mode after reboot

# Restart processes
killall Finder
killall SystemUIServer
killall Dock