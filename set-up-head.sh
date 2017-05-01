# Update all packages
sudo apt-get update -y
sudo apt-get upgrade -y
#
# Install additional packages
sudo apt-get install nmap -y
#
# Make keys for passwordless ssh (for users pi and student)
cat /dev/zero | ssh-keygen -q -N ""
sudo -H -u student bash -c 'cat /dev/zero | ssh-keygen -q -N ""'
#
# Show the login screen at startup
sudo sed -i -e 's/autologin-user=pi/#autologin-user=pi/' /etc/lightdm/lightdm.conf
#
# Set the hostname for this computer
sudo sh -c 'echo picluster > /etc/hostname'
sudo sed -i -e '/127.0.1.1/ s/raspberrypi/picluster/' /etc/hosts
#
# Reboot
read -p "Press the <enter> key to reboot the computer and complete the setup..."
sudo shutdown -r now
