# auto-sh1mmer

## Disclaimer: skids beware!

Using this project requires a significant bit of knowledge about \*nix shells, the boot process and drive partitioning. Before you even run this on your system, be sure to read through it to understand what it does! I'm **not responsible** if you mess up following the instructions!

This project does not produce a signed RMA shim. If you want to sign a RMA shim, you need to extract the proprietary components from an official ChromeOS shim, which I will not provide for legal reasons.

The creator of this project **does not** endorse un-enrolling your Chromebook where it would violate the terms of any legally binding agreement or be illegal in any other fashion. The creator **does not**, under any circumstances, take any liability for what is done with this project.

## Usage

> Ye be warned: these are instructions intended for experienced \*nix users! Go back to [README.md](https://github.com/rainestorme/auto-sh1mmer) for simpler instructions!

**These instructions are intended to be run on a fresh install of Ubuntu 20.04 LTS Desktop/Server, with at least 45gb of storage space available. Only run these commands as root if the instructions say so.**

1. Clone the repo and `cd` into it.
2. Find the board that you're building for (see [Building a Shim](https://github.com/rainestorme/auto-sh1mmer)).
3. Pass that board into `autoshim.sh`: `./autoshim.sh <board>`
4. When shown a shell prompt with the prefix `(cr)`, run `exit`.
5. Once finished, you can optionally add the `sh1mmer` payload by running: `./injectsh1mmer.sh ~/chromiumos/chroot/mnt/imgs/build_shim.bin`

## Injecting sh1mmer into a prebuilt shim

1. It's pretty simple. Just run: `./injectsh1mmer.sh /path/to/shim.bin`

## Flashing a USB drive

1. There are a couple of options for this. If you're on \*nix, use `dd` to flash the shim to a drive, or, if you're on Windows, you can use Rufus in `dd` mode. If you're on MacOS, you're screwed. Sorry. Get a better OS.

## Booting the shim

1. Just follow the instructions in [README.md](https://github.com/rainestorme/auto-sh1mmer).
