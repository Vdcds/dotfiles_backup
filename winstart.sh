#!/bin/bash

# Start the VM if it's not already running
virsh start win11 2>/dev/null || true

# Launch virt-viewer in scaled mode with other options
virt-viewer --kiosk-quit=on-disconnect --wait --reconnect --scaling=always win11
