#!/bin/bash

# Function to add or update SSH config
update_ssh_config() {
    local alias_name=$1
    local hostname=$2
    local user=$3
    local config_file=~/.ssh/config

    # Check if the alias already exists
    if grep -q "^Host $alias_name$" "$config_file"; then
        echo "Updating existing alias: $alias_name"
        # Update the existing alias
        sed -i '' "/^Host $alias_name$/,/^Host /{s/^HostName .*/HostName $hostname/;s/^User .*/User $user/}" "$config_file"
    else
        echo "Adding new alias: $alias_name"
        # Add a new alias
        echo -e "\nHost $alias_name\n    HostName $hostname\n    User $user" >> "$config_file"
    fi
}

# Ask for input
read -p "Enter SSH alias name: " alias_name
read -p "Enter HostName (IP or domain): " hostname
read -p "Enter User: " user

# Call the function with provided inputs
update_ssh_config "$alias_name" "$hostname" "$user"

echo "SSH config updated successfully."

