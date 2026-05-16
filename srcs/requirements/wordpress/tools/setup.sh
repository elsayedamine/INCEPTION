#!/bin/sh

# 1. Wait for MariaDB to be fully ready
while ! mysqladmin ping -h"$DB_HOST" --silent; do
    echo "waiting for mysql ..."
    sleep 2
done

# Check if WordPress is already installed to prevent re-running
if [ ! -f "wp-config.php" ]; then

    echo "Downloading WordPress..."
    wp core download --allow-root

    # 2. CREATE the wp-config.php file FIRST
    echo "Creating wp-config.php..."
    wp config create --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$DB_HOST" 

    # 3. NOW set the Redis configurations inside the newly created file
    echo "Configuring Redis cache settings..."
    wp config set WP_CACHE true --raw --allow-root
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root

    # 4. Install WordPress tables
    echo "Installing WordPress..."
    wp core install --allow-root \
        --url="$WP_DOMAIN" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASS" \
        --admin_email="$WP_ADMIN_EMAIL"

    # 5. Create your secondary user
    echo "Creating second user..."
    wp user create "$WP_USER" "$WP_EMAIL" \
        --user_pass="$USER_PASSWORD" \
        --allow-root

    # 6. Install and activate the caching engine
    echo "Installing and activating Redis Cache plugin..."
    wp plugin install redis-cache --activate --allow-root
    wp redis enable --allow-root

else
    echo "WordPress configuration already exists. Skipping setup routines."
fi

echo "Starting PHP-FPM..."
exec php-fpm8.2 -F