#!/bin/sh

# homebrew
echo "Checking homebrew packages..."
brew update > /dev/null;
new_packages=$(brew outdated --quiet)
num_packages=$(echo $new_packages | wc -w)

if [ $num_packages -gt 0 ]; then
    echo "New package updates available:"
    for package in $new_packages; do
	echo "   * $package";
    done
else
    echo "No new package updates available."
fi

# macOS
echo "Checking macOS updates..."
softwareupdate -l | tail +5
