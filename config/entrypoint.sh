#!/bin/bash
set -e

# 1. Ensure the privilege separation directory exists (Fixes "Missing privilege separation directory")
mkdir -p /var/run/sshd

# 2. Generate host keys if they are missing (Fixes "No host keys available")
if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
    echo "Generating Host Keys..."
    ssh-keygen -A
fi

# 3. Fix permissions for the mounted private key (for pdsh)
if [ -f /root/.ssh/id_rsa ]; then
    echo "Fixing private key permissions..."
    chmod 600 /root/.ssh/id_rsa
fi

echo "Starting SSH Daemon..."
# 4. Exec into the command passed by Docker (sshd -D)
exec "$@"