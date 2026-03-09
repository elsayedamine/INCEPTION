#!/bin/bash
set -e

WP_PATH="/var/www/html"
CONFIG_FILE="$WP_PATH/wp-config.php"

# Wait for MariaDB to be ready
sleep 10

# Only create wp-config.php if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    cp "$WP_PATH/wp-config-sample.php" "$CONFIG_FILE"

    # Replace DB credentials with env variables
    sed -i "s/database_name_here/${MYSQL_DATABASE}/" "$CONFIG_FILE"
    sed -i "s/username_here/${MYSQL_USER}/" "$CONFIG_FILE"
    sed -i "s/password_here/${MYSQL_PASSWORD}/" "$CONFIG_FILE"
    sed -i "s/localhost/${MYSQL_HOST}/" "$CONFIG_FILE"

    # Append dynamically generated salts
    SALTS=$(curl -s https://api.wordpress.org/secret-key/1.1/salt/)
    # Replace placeholder define() lines
    sed -i "/AUTH_KEY/d" "$CONFIG_FILE"
    sed -i "/SECURE_AUTH_KEY/d" "$CONFIG_FILE"
    sed -i "/LOGGED_IN_KEY/d" "$CONFIG_FILE"
    sed -i "/NONCE_KEY/d" "$CONFIG_FILE"
    sed -i "/AUTH_SALT/d" "$CONFIG_FILE"
    sed -i "/SECURE_AUTH_SALT/d" "$CONFIG_FILE"
    sed -i "/LOGGED_IN_SALT/d" "$CONFIG_FILE"
    sed -i "/NONCE_SALT/d" "$CONFIG_FILE"

    # Insert salts after the DB settings
    sed -i "/^define('DB_COLLATE'/a $SALTS" "$CONFIG_FILE"

    echo "wp-config.php created successfully!"
fi

# Ensure PHP-FPM has its runtime folder
mkdir -p /run/php

# Start PHP-FPM in foreground
exec php-fpm8.2 -F