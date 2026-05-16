#!/bin/bash
set -e

# Only configure if the user doesn't exist yet
if ! id "$FTP_USER" >/dev/null 2>&1; then
    echo "Creating FTP user: $FTP_USER"
    
    # Create user with home directory pointing directly to the WordPress volume
    useradd -m -d /var/www/wordpress -s /bin/bash -G www-data "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | chpasswd

    # Ensure vsftpd user list exists
    touch /etc/vsftpd.userlist
    echo "$FTP_USER" | tee -a /etc/vsftpd.userlist > /dev/null

    # Configure vsftpd on the fly
    sed -i "s/#write_enable=YES/write_enable=YES/" /etc/vsftpd.conf
    sed -i "s/#chroot_local_user=YES/chroot_local_user=YES/" /etc/vsftpd.conf

    cat > /etc/vsftpd.conf <<EOF
        listen=YES
        listen_ipv6=NO
        anonymous_enable=NO
        local_enable=YES
        local_umask=002
        write_enable=YES
        chroot_local_user=YES
        allow_writeable_chroot=YES
        seccomp_sandbox=NO
        pasv_enable=YES
        pasv_min_port=40000
        pasv_max_port=40005
        local_root=/var/www/wordpress
        userlist_file=/etc/vsftpd.userlist
EOF

    # Balance ownership so WordPress and FTP can both read/write files
    chown -R www-data:www-data /var/www/wordpress
    find /var/www/wordpress -type d -exec chmod 775 {} \;
    find /var/www/wordpress -type f -exec chmod 664 {} \;
fi

echo "Starting vsftpd daemon in foreground..."
exec vsftpd /etc/vsftpd.conf