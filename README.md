# Installation procedure

## Windows 10 Installation

[Classic installation](https://www.howtogeek.com/197559/how-to-install-windows-10-on-your-pc/) of a [Windows 10 ISO](https://www.microsoft.com/en-us/software-download/windows10) on the machine, don't forget to leave some room on the hard drive for Fedora (minimum 50 GB recommended)

## Fedora 28 Installation

[Installation](https://docs.fedoraproject.org/f28/install-guide/install/Preparing_for_Installation.html) of [Fedora 28 with the XFCE Desktop](http://archive.fedoraproject.org/pub/fedora/linux/releases/28/Spins/x86_64/iso/)

## Installing dump scripts

Download [installation scripts](https://gitlab.com/EpitechContent/dump) to `/tmp`

Go to `/tmp` (cd) and `chmod +x install_packages_dump.sh`

Launch `./install_packages_dump.sh` as root user or else `sudo /tmp/install_packages_dump.sh`

# FAQ

### Can I install Fedora first?

Yes, after installing Fedora, perform a [classic installation](https://www.howtogeek.com/197559/how-to-install-windows-10-on-your-pc/) of a [Windows 10 ISO](https://www.microsoft.com/en-us/software-download/windows10) on the machine, make sure that it uses the remaining space and does not delete the Fedora partitions (otherwise, try again).

### After installing Fedora and Windows 10, it starts only on Windows 10, what should you do?

In your BIOS, select the boot order, if a Fedora entry exists, put it first, otherwise the bios will usually suggest creating a custom entry: `\EFI\fedora\grubx64.efi`, don't forget to place this custom entry first in the startup order. This procedure and its necessity depend on the type of computer on which the installation is made.

_Since Windows 10 Falls Creator (October 2017), it seems that Microsoft takes into account (sometimes) the existing grub and does not rewrite it, if you install Windows 10, remember to check the version of the downloaded ISO._
