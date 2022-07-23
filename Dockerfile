FROM ubuntu:22.04
ARG dsversion=3.4.3

# install software
RUN apt-get update && apt-get install bind9 supervisor curl openssl ca-certificates -y --no-install-recommends && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# download directslave and unzip
RUN curl https://directslave.com/download/directslave-$dsversion-advanced-all.tar.gz -o directslave.tar.gz
RUN tar -xf directslave.tar.gz --directory /usr/local
RUN rm directslave.tar.gz
RUN mv /usr/local/directslave/etc/directslave.conf.sample /usr/local/directslave/etc/directslave.conf
RUN rm /usr/local/directslave/bin/directslave-freebsd-amd64 \
    /usr/local/directslave/bin/directslave-freebsd-i386 \
    /usr/local/directslave/bin/directslave-linux-arm \
    /usr/local/directslave/bin/directslave-linux-i386 \
    /usr/local/directslave/bin/directslave-macos-amd64

# configure DirectSlave
RUN sed -i 's#Change_this_line_to_something_long_&_secure#'"$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"'#g' /usr/local/directslave/etc/directslave.conf
RUN sed -i "s/53/$(id -u bind)/g" /usr/local/directslave/etc/directslave.conf
RUN sed -i "s/53/$(id -u bind)/g" /usr/local/directslave/etc/directslave.conf
RUN sed -i "s/privkey.pem/key.pem/g" /usr/local/directslave/etc/directslave.conf
RUN sed -i "s/2222/2221/g" /usr/local/directslave/etc/directslave.conf
RUN sed -i "s/2224/2222/g" /usr/local/directslave/etc/directslave.conf
RUN sed -i "s/debug		1/debug		0/g" /usr/local/directslave/etc/directslave.conf
RUN sed -i "s/\/etc\/namedb\/directslave.inc/\/var\/lib\/bind\/slave\/directslave.inc/g" /usr/local/directslave/etc/directslave.conf
RUN sed -i "s/\/etc\/namedb\/secondary/\/var\/lib\/bind\/slave/g" /usr/local/directslave/etc/directslave.conf
RUN sed -i "s/\/usr\/local\/bin\/rndc/\/usr\/sbin\/rndc/g" /usr/local/directslave/etc/directslave.conf
RUN mkdir -p /var/lib/bind/slave
RUN touch /var/lib/bind/slave/directslave.inc

# configure bind9
RUN echo "include \"/var/lib/bind/slave/directslave.inc\";" >> /etc/bind/named.conf

# SSL certificate
RUN openssl req -x509 -newkey rsa:4096 -sha256 -days 3650 -nodes \
  -keyout /usr/local/directslave/ssl/key.pem -out /usr/local/directslave/ssl/fullchain.pem -subj "/CN=directslave" \
  -addext "subjectAltName=DNS:directslave"
RUN rm /usr/local/directslave/ssl/privkey.pem


# permissions
RUN chmod +x /usr/local/directslave/bin/*
RUN chown -R bind:bind /usr/local/directslave
RUN chown -R bind:bind /var/lib/bind/slave

# test
RUN /usr/local/directslave/bin/directslave-linux-amd64 --check
RUN rm /usr/local/directslave/etc/passwd

# supervisord 
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# ports
EXPOSE 53/udp 53/tcp 2221/tcp 2222/tcp

HEALTHCHECK CMD curl --fail http://localhost:2221/ || exit 1

# ENTRYPOINT
COPY ./entry.sh /usr/local/directslave/entry.sh
RUN chmod +x /usr/local/directslave/entry.sh
ENTRYPOINT ["/usr/local/directslave/entry.sh"]