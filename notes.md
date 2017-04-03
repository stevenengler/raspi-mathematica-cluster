How to format an SD card and remove an existing OS: Download and use the offical SD card formatter at https://www.sdcard.org/downloads/formatter_4/

For headless nodes: Download and image Raspbian lite.
For main head node: Download and image Raspbian non-lite.

For both:
After imaging, create an empty file in the root of the card named 'ssh'.
Create the file `wpa_supplicant.conf` and add the following:
```
network={
  ssid="PhysLab"
  psk="<Insert Password Here>"
}
```


Run script:
```bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install ntpdate -y
#
sudo cp /usr/share/zoneinfo/Canada/Eastern /etc/localtime
sudo service ntp stop
sudo ntpdate -s time.nist.gov
sudo service ntp start
#
sudo rm /etc/motd
sudo touch /etc/motd
```

On head:
```bash
sudo sed -i -e '/XKBLAYOUT=/ s/=.*/="en"/' /etc/default/keyboard
sudo sed -i -e '/XKBMODEL=/ s/=.*/="pc104"/' /etc/default/keyboard
sudo sh -c 'echo picluster > /etc/hostname'
sudo sed -i -e '/127.0.1.1/ s/raspberrypi/picluster/' /etc/hosts
echo "pi:<Insert Password Here>" | sudo chpasswd
# ^^^ must reboot to take effect
sudo apt-get install nmap -y
```



To search network for Pis:
```bash
sudo nmap -sP 192.168.1.0/24 | awk '/^Nmap/{ip=$NF}/B8:27:EB/{print ip}'
```


Background at: `~/.config/pcmanfm/LXDE-pi`.
Change password for pi user!!


Add users:
```bash
sudo adduser steve <<< asks for keyboard input (ex: password) >>>
sudo adduser steve sudo
```


Time servers not working!!!!!
