#!/bin/bash
# #!/bin/bash
# service mariadb start

# # Wait for MariaDB to be ready (The "Health Check")
# until mysqladmin ping >/dev/null 2>&1; do
#     sleep 3
# done

# # If the database directory doesn't exist, create it
# if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
#     mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
#     mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#     mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
#     mysql -e "FLUSH PRIVILEGES;"
#     mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
# fi

# mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# # Start in foreground
# exec mysqld
service mariadb start

mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

mysqld