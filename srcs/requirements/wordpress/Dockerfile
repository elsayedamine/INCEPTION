FROM debian:12

RUN apt update && apt install -y \
    php8.2-fpm php8.2-mysql wget unzip

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && rm -rf latest.zip

EXPOSE 9000

ENTRYPOINT ["php-fpm8.2", "-F"]