# Update all packages
sudo apt-get update -y
sudo apt-get upgrade -y
#
# Install additional packages
sudo apt-get install ntpdate -y
sudo apt-get install vim -y
sudo apt-get install wolfram-engine -y
#
# Fix keyboard layout and language
sudo sed -i -e '/XKBLAYOUT=/ s/=.*/="en"/' /etc/default/keyboard
sudo sed -i -e '/XKBMODEL=/ s/=.*/="pc104"/' /etc/default/keyboard
#
# Set the correct timezone
sudo cp /usr/share/zoneinfo/Canada/Eastern /etc/localtime
#
# Remove unneeded messages from the shell on first login
sudo rm /etc/motd
sudo touch /etc/motd
#
# Prompt for a new password for the 'pi' user
echo "Changing the password for the 'pi' user (original password will be 'raspberry')..."
passwd
#
# Create a new non-sudo user
echo "Creating a new user named 'student'. Please choose a password..."
sudo adduser student
#
# Add student to video group (needed for Mathematica)
sudo adduser student video
