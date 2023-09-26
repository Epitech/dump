# Installation procedure

## Windows 10 Installation

[Classic installation](https://www.howtogeek.com/197559/how-to-install-windows-10-on-your-pc/) of a [Windows 10 ISO](https://www.microsoft.com/en-us/software-download/windows10) on the machine, don't forget to leave some room on the hard drive for Fedora (minimum 50 GB recommended)

## Fedora 38 Installation

[Installation](https://docs.fedoraproject.org/en-US/fedora/f38/install-guide/install/Preparing_for_Installation/index.html) of [Fedora 36 with selected Desktop](https://archive.fedoraproject.org/pub/fedora/linux/releases/38/Spins/x86_64/iso/)

## Installing dump scripts

Download [installation scripts](https://github.com/Epitech/dump) to `/tmp`

Go to `/tmp` (cd) and `chmod +x install_packages_dump.sh`

Launch `./install_packages_dump.sh` as root user or else `sudo /tmp/install_packages_dump.sh`

# FAQ

### Can I install Fedora first?

Yes, after installing Fedora, perform a [classic installation](https://www.howtogeek.com/197559/how-to-install-windows-10-on-your-pc/) of a [Windows 10 ISO](https://www.microsoft.com/en-us/software-download/windows10) on the machine, make sure that it uses the remaining space and does not delete the Fedora partitions (otherwise, try again).

### After installing Fedora and Windows 10, it starts only on Windows 10, what should you do?

In your BIOS, select the boot order, if a Fedora entry exists, put it first, otherwise the bios will usually suggest creating a custom entry: `\EFI\fedora\grubx64.efi`, don't forget to place this custom entry first in the startup order. This procedure and its necessity depend on the type of computer on which the installation is made.
