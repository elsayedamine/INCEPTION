FROM debian:12

RUN apt update && apt install nginx openssl -y

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=MA/ST=Casablanca/L=Casablanca/O=42/OU=student/CN=aelsayed.42.fr"

RUN rm -rf /etc/nginx/sites-enabled/default

COPY ./conf/server.conf /etc/nginx/conf.d/

RUN chmod 755 /var/www/html

# nginx uses this user
RUN chown -R www-data:www-data /var/www/html 

RUN rm -rf /var/www/html/* 

EXPOSE 443

# ENTRYPOINT ["nginx", "-g", "daemon off;"]