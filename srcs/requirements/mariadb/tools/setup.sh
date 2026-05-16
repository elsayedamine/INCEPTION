#!/bin/bash

# Ensure runtime directories exist with proper ownership
mkdir -p /var/run/mysqld /var/lib/mysql
chown -m 755 /var/run/mysqld
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# If the system database tables don't exist, build them!
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "System tables missing. Initializing MariaDB system databases..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# If our custom initialization flag hasn't been created yet, do configuration
if [ ! -f /var/lib/mysql/.initialized ]; then

    echo "Booting temporary server for user setup..."
    service mariadb start

    # Wait for the temporary background service to accept sockets
    until mysqladmin ping --silent; do
        echo "Waiting for MariaDB to start..."
        sleep 1
    done

    echo "Creating database and users..."
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
    mysql -e "FLUSH PRIVILEGES;"

    touch /var/lib/mysql/.initialized
    
    echo "Stopping temporary setup server..."
    service mariadb stop
    sleep 2
fi

echo "Starting MariaDB in production foreground mode..."
exec mysqld --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0 --port=3306