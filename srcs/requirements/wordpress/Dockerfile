FROM debian:12

RUN apt update && apt install -y \
    php8.2-fpm php8.2-mysql wget unzip

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && mv wordpress/* ./ \
    && rm -rf wordpress latest.zip

COPY ./conf/wp-config.php ./wp-config.php

RUN sed -i 's|^listen = .*|listen = wordpress:9000|' /etc/php/8.2/fpm/pool.d/www.conf \
    && echo "clear_env = no" >> /etc/php/8.2/fpm/pool.d/www.conf

EXPOSE 9000

ENTRYPOINT ["php-fpm8.2", "-F"]