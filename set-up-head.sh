# Update all packages
sudo apt-get update -y
sudo apt-get upgrade -y
#
# Install additional packages
sudo apt-get install nmap -y
#
# Set the hostname for this computer
sudo sh -c 'echo picluster > /etc/hostname'
sudo sed -i -e '/127.0.1.1/ s/raspberrypi/picluster/' /etc/hosts
#
# Make keys for passwordless ssh (for users pi and student)
cat /dev/zero | ssh-keygen -q -N ""
sudo -H -u student bash -c 'cat /dev/zero | ssh-keygen -q -N ""'
#
# Reboot
read -p "Press the <enter> key to reboot the computer and complete the setup..."
sudo shutdown -r now