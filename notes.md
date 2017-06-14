# Instructions

## Formatting the SD cards and installing Raspbian

If the SD card already has an operating system installed, you may need to format the SD card first using the offical SD card formatter at https://www.sdcard.org/downloads/formatter_4/

For headless nodes:
- Download Raspbian lite.  

For main head node:
- Download Raspbian with PIXEL.

Install the Raspbian image on the SD card by following the instructions here: https://www.raspberrypi.org/documentation/installation/installing-images/

For both:
- After imaging, create an empty file in the root of the card named 'ssh' (enables ssh access).  
- (Optional) If using Wi-Fi rather than ethernet, create the file `wpa_supplicant.conf` and add the following:
```
network={
  ssid="PhysLab"
  psk="<Insert Password Here>"
}
```

## Setting up the Pi's

During the setup process below, you will be asked to create new passwords for the pi and student users. Please use different passwords for both accounts, but use consistent passwords for each account across all Pi's.

Default password for user pi: `raspberry`

If asked to verify authenticity of a host, choose 'yes'.

The process will take a while for each Pi, but you can perform the setup for multiple node Pi's at once.

### Set Static IP Addresses

The steps depend on your router, but you should set static IP addresses for each Pi.

### Setting up head Pi

The code below downloads the scripts from Github and runs them.

```bash
$ cd ~
$ git clone https://github.com/stevenengler/raspi-mathematica-cluster
$ cd raspi-mathematica-cluster
$ ./set-up-all.sh
$ ./set-up-head.sh
```

### Setting up node Pi's

Run this code from the head Pi after you have set it up. You need to know the IP address of the Pi, and you must choose an integer to give it as an ID number.

```bash
$ cd ~/raspi-mathematica-cluster
$ ./set-up-node.sh
```

## If Mathematica cannot start a kernel on a remote Pi

The included script to launch kernels was designed so that output (stdout and stderr) are written to the files `~/stdout.txt` and `~/stderr.txt` on the node. You can check these files for error messages.

Example:

```bsh
$ ssh picluster_<x>
$ more ~/stderr.txt
$ more ~/stdout.txt
$ exit
```

## Other notes

To fix the clock (not persistent):
```bash
$ sudo service ntp stop
$ sudo ntpdate -s time.nist.gov
$ sudo service ntp start
```

To search network for Pi's:
```bash
$ sudo nmap -sP 192.168.1.0/24 | awk '/^Nmap/{ip=$NF}/B8:27:EB/{print ip}'
```

Background at: `~/.config/pcmanfm/LXDE-pi`.
Change password for pi user!!

Time servers not working!!!!!
