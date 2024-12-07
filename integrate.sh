#!/bin/bash

# Define paths
SCRIPT_PATH="/usr/local/bin/flatpak-menu-sync.py"
SERVICE_PATH="/etc/systemd/system/flatpak-menu-sync.service"
LOG_PATH="/var/log/flatpak-menu-sync.log"

# Copy the Python script
echo "Copying Python script to $SCRIPT_PATH..."
sudo cp flatpak-menu-sync.py $SCRIPT_PATH
sudo chmod +x $SCRIPT_PATH

# Copy the systemd service file
echo "Copying systemd service file to $SERVICE_PATH..."
if [ ! -f flatpak-menu-sync.service ]; then
    echo "flatpak-menu-sync.service not found. Please see the example file flatpak-menu-sync.service.example and modify it to your needs, then rename it to flatpak-menu-sync.service and run this script again."
    exit 1
fi
sudo cp flatpak-menu-sync.service $SERVICE_PATH || echo "Failed to copy service file. Please check the permissions and try again."

# Reload systemd daemon
echo "Reloading systemd daemon..."
sudo systemctl daemon-reload

# Enable and start the service
echo "Enabling and starting the flatpak-menu-sync service..."
sudo systemctl enable flatpak-menu-sync
sudo systemctl start flatpak-menu-sync

# Create log file if it doesn't exist
if [ ! -f "$LOG_PATH" ]; then
    echo "Creating log file at $LOG_PATH..."
    sudo touch $LOG_PATH
    sudo chown root:root $LOG_PATH
    sudo chmod 644 $LOG_PATH
fi

# Check if the service is running
if sudo systemctl is-active flatpak-menu-sync.service > /dev/null 2>&1; then
    echo "The flatpak-menu-sync service is now running."
    echo "You can check the status of the service with 'systemctl status flatpak-menu-sync.service'"
    echo "You can check the logs of the service with 'journalctl -u flatpak-menu-sync.service'"
    echo "Happy flatpakbing!"
else
    echo "The flatpak-menu-sync service failed to start. Please check the logs for more information."
fi