#!/bin/bash
service mariadb start

# Wait for MariaDB to be ready (The "Health Check")
until mysqladmin ping >/dev/null 2>&1; do
    sleep 3
done

# If the database directory doesn't exist, create it
if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
    mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
    mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';"
    mysql -e "FLUSH PRIVILEGES;"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
fi

mysqladmin -u root -p$SQL_ROOT_PASSWORD shutdown

# Start in foreground
exec mysqld