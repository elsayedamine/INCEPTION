FROM debian:12

RUN apt update && apt install git make build-essential nodejs python3 -y

RUN git clone https://github.com/elsayedamine/WEBSERV /webserv

WORKDIR /webserv

COPY conf/webserv.conf sandbox/webserv.conf

RUN make re

ENTRYPOINT ["./webserv", "sandbox/webserv.conf"]
