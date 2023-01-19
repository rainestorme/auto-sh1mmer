#!/bin/sh

echo "This script automatically injects sh1mmer into a previously built image."
echo "This assumes that you've either built an RMA shim using AutoShim or that you've sourced your own image."
echo "This should be passed the path to the image you want to inject sh1mmer into."
echo "This will take about 5gb of disk space."
sleep 3

echo "Installing required packages..."
sudo apt-get update -y
sudo apt-get install -y cgpt

echo "Downloading sh1mmer source tree..."
git clone https://github.com/CoolElectronics/sh1mmer.git

echo "Downloading Chromebrew tarball..."
cd sh1mmer/wax
wget https://dl.sh1mmer.me/build-tools/chromebrew/chromebrew.tar.gz

echo "Copying image to sh1mmer directory..."
cp $1 ./shim.bin

echo "Starting image injection via wax.sh..."
sudo ./wax.sh shim.bin

echo "Hopefully, sh1mmer worked. If it outputted an error about loopbacks, please press Ctrl+C in the next 3 seconds to cancel the further execution of the script."
sleep 3

echo "Copying image to auto-sh1mmer directory..."
cp shim.bin ../../sh1mmer-payload.bin

echo "Cleaning up..."
cd ../../
rm -Rf sh1mmer

echo "Done! Your image should be located in ./sh1mmer-payload.bin"
echo "You can flash this image to your USB drive using the following command (assuming you're on linux): "
echo "dd if=./sh1mmer-payload.bin of=/dev/sdx    (note: /dev/sdx should be replaced with the block device representing your USB drive. Be careful! DD has been nicknamed 'disk destroyer' for a reason!)"
echo "Or, if you're on Windows, you can use Rufus to flash the image to your USB drive. Just make sure to select 'DD mode' to ensure compatibility."
echo "If you're on macOS, you're screwed. You'll have to use a VM or something."