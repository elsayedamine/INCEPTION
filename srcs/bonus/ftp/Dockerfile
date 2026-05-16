FROM debian:12

RUN apt-get update && apt-get install -y \
    vsftpd \
    && rm -rf /var/lib/apt/lists/*

# Create the mandatory secure empty directory vsftpd requires to boot
RUN mkdir -p /var/run/vsftpd/empty

COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/setup.sh /usr/local/bin/setup.sh

RUN chmod +x /usr/local/bin/setup.sh

# Expose FTP control port (21) and the passive data port spectrum (40000-40005)
EXPOSE 21 40000-40005

ENTRYPOINT ["sh", "/usr/local/bin/setup.sh"]