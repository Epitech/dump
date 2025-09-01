# Classic installation procedure

Dump your pc with tools provided by school (PXE or USB Keys)

Run this command in a root shell (`sudo -i`) :

```sh
wget -O - "http://dumpscript.epitest.eu" | bash -s
```
(a simple web redirect to dump.sh script in this repository)

Or as a non-root shell (prompt await for password)

```sh
wget -O - "http://dumpscript.epitest.eu" | sudo bash -s
```

In the event of a connection to the PXE dump machine, it is possible that no DNS settings will have been configured. In such a scenario, it is recommended to run the following command as a preliminary measure.
```sh
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
```

# Manual Installation procedure

## Windows 11 installation

Do a [Classic Installation](https://www.tomshardware.com/how-to/clean-install-windows-11) of a [Windows 11 ISO](https://www.microsoft.com/en-us/software-download/windows11) on the machine, don't forget to leave some space on the hard drive for Ubuntu (at least 50 GB recommended).

## Ubuntu 24.04 Installation

[Ubuntu 24.04](https://releases.ubuntu.com/noble/)

## Install dump scripts

Download [installation scripts](https://github.com/Epitech/dump) to `/tmp`.

Go to `/tmp` (cd) and `chmod +x dump.sh`.

Run `./dump.sh` as root or `sudo /tmp/dump.sh`.

# FAQ

### Can I install Ubuntu first?

Yes, after installing Ubuntu, install Windows on the machine, making sure it uses the remaining space and does not delete the Ubuntu partitions (otherwise try again).

### After installing Ubuntu and Windows 11, it only boots into Windows 11, what should I do?

[Changing the boot order](https://askubuntu.com/a/1394945)