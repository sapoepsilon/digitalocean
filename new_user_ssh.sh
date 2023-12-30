#!/bin/bash

# Ask for the droplet's IP address, new user name, and the SSH public key
read -p "Enter the Droplet's IP Address: " droplet_ip
read -p "Enter the new username: " new_user
read -p "Paste the SSH public key here: " ssh_key

# Define the SSH command to be used for connecting to the droplet
ssh_command="ssh root@$droplet_ip"

# Create the new user and add them to the sudo group
$ssh_command "adduser $new_user && usermod -aG sudo $new_user"

# Create .ssh directory and authorized_keys, then set correct permissions
$ssh_command "mkdir -p /home/$new_user/.ssh && echo $ssh_key > /home/$new_user/.ssh/authorized_keys && chmod 700 /home/$new_user/.ssh && chmod 600 /home/$new_user/.ssh/authorized_keys && chown -R $new_user:$new_user /home/$new_user/.ssh"

echo "User $new_user added successfully with provided SSH key."

