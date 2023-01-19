# auto-sh1mmer

## Disclaimer: skids beware!

Using this project requires a significant bit of knowledge about \*nix shells, the boot process and drive partitioning. Before you even run this on your system, be sure to read through it to understand what it does! I'm **not responsible** if you mess up following the instructions!

## Usage

> Ye be warned: these are instructions intended for experienced \*nix users! Go back to [README.md](https://github.com/rainestorme/auto-sh1mmer) for simpler instructions!

**These instructions are intended to be run on a fresh install of Ubuntu 20.04 LTS Desktop/Server, with at least 45gb of storage space available.**

1. Clone the repo and `cd` into it.
2. Find the board that you're building for (see [Building a Shim](https://github.com/rainestorme/auto-sh1mmer)).
3. Pass that board into `autoshim.sh`: `./autoshim.sh <board>`
4. When shown a shell prompt with the prefix `(cr)`, run `exit`.
5. Once finished, you can optionally add the `sh1mmer` payload by running: `./injectsh1mmer.sh ~/chromiumos/chroot/mnt/imgs/build_shim.bin`

## Injecting sh1mmer into a prebuilt shim

1. It's pretty simple. Just run: `./injectsh1mmer.sh /path/to/shim.bin`

## Flashing a USB drive

1. There are a couple of options for this. If you're on \*nix, use `dd` to flash the shim to a drive, or, if you're on Windows, you can use Rufus in `dd` mode. If you're on MacOS, you're screwed. Sorry. Get a better OS.
