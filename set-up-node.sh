# Get the IP address of the node Pi and the ID you want to give the node
echo "Enter IP address of the node Pi:"
read NODE_IP
echo "Enter an integer > 0 to use as the node index:"
read NODE_ID
#
# Copy the ssh keys to the node for the pi user
ssh-copy-id pi@$NODE_IP
#
# Copy the setup script to the node, run it, and set up the host name
scp set-up-all.sh pi@$NODE_IP:~
ssh pi@$NODE_IP 'chmod 744 set-up-all.sh'
ssh -tt pi@$NODE_IP './set-up-all.sh'
ssh pi@$NODE_IP 'rm -f set-up-all.sh'
ssh pi@$NODE_IP "sudo sh -c \"echo picluster_$NODE_ID > /etc/hostname\""
ssh pi@$NODE_IP "sudo sed -i -e \"/127.0.1.1/ s/raspberrypi/picluster_$NODE_ID/\" /etc/hosts"
ssh pi@$NODE_IP "sudo hostname picluster_$NODE_ID"
#
# Copy the ssh keys to the node for the student user
sudo -H -u student bash -c "ssh-copy-id student@$NODE_IP"
#
# Add the host name for the new node
sudo sh -c "echo \"$NODE_IP\tpicluster_$NODE_ID\" >> /etc/hosts"
#
# Connect to the node (with both accounts) using the new hostname so that it accepts the new signature
ssh pi@picluster_$NODE_ID 'echo "done (1)."'
sudo -H -u student bash -c "ssh student@picluster_$NODE_ID 'echo \"done (2).\"'"
#
# Restart the remote node
echo "The node Pi will now restart. Please be patient when trying to connect to it."
ssh -n -f pi@$NODE_IP "sh -c 'sudo nohup shutdown -r now > /dev/null 2>&1 &'"
