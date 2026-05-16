FROM debian:12

RUN apt-get update && apt-get install -y mariadb-server

RUN mkdir -p /var/lib/mysql \
    /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

EXPOSE 3306

COPY ./tools/setup.sh /
RUN chmod +x /setup.sh

CMD [ "/setup.sh" ]