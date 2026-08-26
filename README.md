# Classic installation procedure

Dump your pc with tools provided by school (PXE or USB Keys)

Run this command in the Terminal app (you will be prompted for your password):

```sh
wget -q -O- https://raw.githubusercontent.com/Epitech/dump/refs/heads/master/dump.sh | sudo bash
```

# Manual Installation procedure

## Windows 11 installation

Do a [Classic Installation](https://www.tomshardware.com/how-to/clean-install-windows-11) of a [Windows 11 ISO](https://www.microsoft.com/en-us/software-download/windows11) on the machine, don't forget to leave some space on the hard drive for Ubuntu (at least 50 GB recommended).

## Ubuntu 26.04 Installation

[Ubuntu 26.04](https://releases.ubuntu.com/26.04/)

## Install dump scripts

Download [installation scripts](https://github.com/Epitech/dump) to `/tmp`.

Go to `/tmp` (cd) and `chmod +x dump.sh`.

Run `./dump.sh` as root or `sudo /tmp/dump.sh`.

# FAQ

### Can I install Ubuntu first?

Yes, after installing Ubuntu, install Windows on the machine, making sure it uses the remaining space and does not delete the Ubuntu partitions (otherwise try again).

### After installing Ubuntu and Windows 11, it only boots into Windows 11, what should I do?

[Changing the boot order](https://askubuntu.com/a/1394945)