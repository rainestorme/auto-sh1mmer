#!/bin/sh

echo "AutoShim - Automatically builds a RMA shim for the passed chromebook board type"
echo "This will use around 45GB of disk space. Make sure you have that much available, or else this script will fail!"
echo "For confirmation: You are currently building a shim for the board type $1."
echo "At any point within the next 8 seconds, you can press Ctrl+C to cancel."
sleep 8

echo "Installing required packages..."
sudo add-apt-repository universe
sudo apt-get update
sudo apt-get install git gitk git-gui curl xz-utils \
    python3-pkg-resources python3-virtualenv python3-oauth2client -y

echo "Installing depot_tools..."
git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$(pwd)/depot_tools/:$PATH

echo && echo
echo "Reinstalling locales..."
sudo apt-get install locales

echo && echo
echo "Ensuring architechture..."
if uname -m | grep '64'; then
  echo "ARCH: 64-bit. You're all good!"
else
  echo "ARCH: 32-bit. Sadly, your system is incompatible."
  exit 1
fi
echo && echo

echo "Creating source directory and cloning repo... This will take a lot of disk space (>10gb)"
echo && echo
mkdir -p ~/chromiumos
cd ~/chromiumos
repo init -u https://chromium.googlesource.com/chromiumos/manifest -b main -g minilayout # Hopefully minilayout should work
repo sync -j$(nproc)

echo && echo
echo "Setting up cros_sdk... (this will take a couple of minutes and about 3GB of disk space)"
echo "Once finished, you will be dropped into a shell. Please type 'exit' to continue the process of building an RMA shim."
echo && echo
sleep 8
cros_sdk

echo && echo
# Good job, you're not a skid! Thanks for actually reading this to see what it does instead of mindlessly giving other people access to your computer!
# If you're wondering about the weird syntax, it's because I'm using a heredoc to pass commands to the chroot shell through stdin.
echo "Beginning chroot-based build..."
cros_sdk <<EOT
echo "Creating shared point for image..."
mkdir -p /mnt/imgs
echo "Setting up board $1..."
setup_board --board=$1
echo "Building packages for $1..."
build_packages --board=$1
echo "Building RMA shim for board $1"
build_image --board $1 factory_install
mv ~/trunk/src/build/images/$1/latest/factory_install_shim.bin /mnt/imgs/build_shim.bin
EOT

echo && echo
echo "Done creating RMA shim! Your image should be located in ~/chromiumos/chroot/mnt/imgs/build_shim.bin"
echo "Leave us a star on GitHub if it worked for you."
echo "If you want to inject the sh1mmer payload (BeautifulWorld) into this shim, run './injectsh1mmer.sh ~/chromiumos/chroot/mnt/imgs/build_shim.bin'."
