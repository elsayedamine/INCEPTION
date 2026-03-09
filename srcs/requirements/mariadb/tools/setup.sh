#!/bin/bash
set -e

# Start MariaDB in the background temporarily
mysqld --skip-networking &

# Wait for MariaDB to be ready
until mysqladmin ping >/dev/null 2>&1; do
    sleep 1
done

# Create database and users from environment variables
mysql <<-EOSQL
    CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
    CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
    FLUSH PRIVILEGES;
EOSQL

mysqladmin shutdown

# Start mysqld in foreground (PID 1)
exec mysqld