FROM debian:12

RUN apt update && apt install vsftpd -y && rm -rf /var/lib/apt/lists/*

# Correct path for vsftpd secure chroot directory on Debian
RUN mkdir -p /var/run/vsftpd/empty && chmod 755 /var/run/vsftpd/empty

# Pull variables from compose environment definitions
ARG FTP_USER FTP_PASS
ENV FTP_USER=$FTP_USER FTP_PASS=$FTP_PASS

COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Run the script WHEN THE CONTAINER STARTS, not when it builds
ENTRYPOINT [ "/usr/local/bin/setup.sh" ]