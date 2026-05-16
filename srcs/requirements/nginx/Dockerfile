FROM debian:12

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl /var/www/wordpress

COPY conf/nginx.conf /etc/nginx/sites-enabled/default

COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

EXPOSE 443

CMD ["/setup.sh"]
