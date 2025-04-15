#!/bin/bash

# Variables
GROUP_NAME="dev_team"
USERS=("ravi" "kiran" "divya")
SHARED_DIR="/srv/dev_data"

# Create group if it doesn't exist
if ! getent group "$GROUP_NAME" > /dev/null; then
  echo "Creating group: $GROUP_NAME"
  sudo groupadd "$GROUP_NAME"
else
  echo "Group $GROUP_NAME already exists."
fi

# Create users and add them to the group
for USER in "${USERS[@]}"; do
  if id "$USER" &>/dev/null; then
    echo "User $USER exists. Adding to $GROUP_NAME..."
    sudo usermod -aG "$GROUP_NAME" "$USER"
  else
    echo "Creating user: $USER"
    sudo useradd -m -G "$GROUP_NAME" "$USER"
    echo "$USER:Welcome123" | sudo chpasswd
  fi
done

# Create shared directory
echo "Creating shared directory: $SHARED_DIR"
sudo mkdir -p "$SHARED_DIR"
sudo chown root:"$GROUP_NAME" "$SHARED_DIR"
sudo chmod 2770 "$SHARED_DIR"

echo "Setup completed. Members of $GROUP_NAME can now access $SHARED_DIR."
