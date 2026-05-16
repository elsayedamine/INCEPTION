FROM debian:12

RUN apt-get update && apt-get install -y \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client \
    curl 

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php && mkdir -p /var/www/wordpress
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/

COPY tools/setup.sh /
RUN chmod +x setup.sh

WORKDIR /var/www/wordpress

EXPOSE 9000

CMD ["/setup.sh"]
