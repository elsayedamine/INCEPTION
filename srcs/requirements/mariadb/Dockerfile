FROM debian:12

RUN apt update && apt install mariadb-server mariadb-client -y

#Allow to run the daemon of mysql
# Purge and re-create /var/lib/mysql with appropriate ownership
# ensure that /var/run/mysqld (used for socket and lock files) is writable regardless of the UID our mysqld instance ends up having at runtime
RUN rm -rf /var/lib/apt/lists/*
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

COPY ./tools/setup.sh /
RUN chmod +x /setup.sh

EXPOSE 3306

ENTRYPOINT ["/setup.sh"]