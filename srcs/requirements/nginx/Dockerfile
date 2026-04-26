FROM debian:12

RUN apt update && apt install nginx openssl -y

RUN mkdir -p /etc/nginx/ssl /var/run/nginx

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/nginx.crt -keyout /etc/nginx/ssl/nginx.key \
    -subj "/C=MA/ST=Benguerir/L=Benguerir/O=1337/OU=1337/CN=aelsayed.42.fr/UID=aelsayed"

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/server.conf /etc/nginx/conf.d/default.conf

RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
