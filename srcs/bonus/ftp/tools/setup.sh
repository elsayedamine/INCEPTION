#!/bin/sh
set -e

# Check if the user exists in /etc/passwd instead of checking a directory
if ! id "$FTP_USER" >/dev/null 2>&1; then
    echo "Creating FTP user: ${FTP_USER}"
    
    # Create the user and explicitly assign their home directory to the WordPress mount
    useradd -d /var/www/wordpress -s /bin/bash ${FTP_USER}
    echo "${FTP_USER}:${FTP_PASS}" | chpasswd

    # Ensure permissions are correctly set up so they can read/write files
    chown -R ${FTP_USER}:${FTP_USER} /var/www/wordpress
else
    echo "FTP user ${FTP_USER} already exists. Skipping creation."
fi

echo "Starting vsftpd daemon..."
exec vsftpd /etc/vsftpd.conf