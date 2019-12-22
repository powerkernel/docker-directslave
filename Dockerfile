FROM debian
# install bind
RUN apt-get update && apt-get install bind9 -y --no-install-recommends && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# copy source
COPY ./directslave /usr/local/
# SESSION RANDOM ID
RUN sed -i 's#Change_this_line_to_something_long_&_secure#'"$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"'#g' /usr/local/directslave/etc/directslave.conf
RUN cat /usr/local/directslave/etc/directslave.conf
# config
RUN mkdir -p /var/lib/bind/slave
RUN touch /var/lib/bind/slave/directslave.inc
RUN echo 'include "/etc/bind/named.conf"' >> /var/lib/bind/slave/directslave.inc
RUN echo 'allow-transfer {"none";};' >> /etc/bind/named.conf.options
RUN touch /usr/local/directslave/etc/passwd
# permissions
RUN chmod +x /usr/local/directslave/bin/*
RUN chown -R bind:bind /usr/local/directslave
RUN chown -R bind:bind /var/lib/bind/slave
# set default password
RUN /usr/local/directslave/bin/directslave-linux-amd64 --password admin:password
# test
RUN /usr/local/directslave/bin/directslave-linux-amd64 --check
# good to go
EXPOSE 2222
CMD /usr/local/directslave/bin/directslave-linux-amd64 --run