FROM debian:12

RUN apt update && apt install -y mariadb-server mariadb-client && rm -rf /var/lib/apt/lists/*

# Ensure MySQL socket and run directories exist and are writable
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 3306

ENTRYPOINT ["/setup.sh"]