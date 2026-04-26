#!/bin/bash

# 1. Wait for the database to be ready
sleep 7

# 2. Download and extract WordPress if not already there
if [ ! -f "wp-config.php" ]; then
    curl -O https://wordpress.org/latest.tar.gz
    tar -xvf latest.tar.gz --strip-components=1
    rm latest.tar.gz

    # 3. Create wp-config from the sample
    cp wp-config-sample.php wp-config.php

    # 4. Use 'sed' to inject your environment variables
    # We use 'i' for in-place editing
    sed -i "s/database_name_here/$SQL_DATABASE/g" wp-config.php
    sed -i "s/username_here/$SQL_USER/g" wp-config.php
    sed -i "s/password_here/$SQL_PASSWORD/g" wp-config.php
    sed -i "s/localhost/mariadb/g" wp-config.php

    # we add redis conf here
fi

# 5. Fix permissions so NGINX and PHP can read/write files
chown -R www-data:www-data /var/www/wordpress

# 6. Create the run directory for PHP-FPM
mkdir -p /run/php

# 7. Start PHP-FPM in foreground
exec /usr/sbin/php-fpm7.4 -F