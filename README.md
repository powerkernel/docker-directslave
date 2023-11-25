# docker-directslave

DirectSlave docker image

## RUN

Download `docker-compose.yml` and set your ENVs, then run:

```bash
docker compose up -d
```

## SSL

```bash
docker exec acme.sh acme.sh --register-account -m admin@$(hostname -f)
docker exec acme.sh --issue -d $(hostname -f) --dns dns_cf
docker exec acme.sh --deploy -d $(hostname -f) --deploy-hook docker
```

## Usefull CMDs

```bash
docker exec directslave /usr/bin/supervisorctl restart
docker exec directslave /usr/bin/supervisorctl status
```

## Config DirectAdmin

add to DirectAdmin named config:

```conf
notify explicit;
also-notify { directslave_IPs; };
allow-notify { directslave_IPs; };
allow-transfer { directslave_IPs; };
```

Then restart named and rewrite all .db

```bash
service named restart
echo "action=rewrite&value=named" >> /usr/local/directadmin/data/task.queue
```

## Helpful script

This script will update directadmin named config with DirectSlave IPs:

```bash
#!/bin/bash

# Define your domain names, config path
domains=("host1.slave.com" "host1.slave.com")
namedPath=/etc/bind/named.conf


# Start the configuration blocks
notify_block="also-notify {"
transfer_block="allow-transfer {"
notify_allow_block="allow-notify {"

# Resolve each domain name to its IPv4 and IPv6 addresses and append them to the configuration blocks
for domain in "${domains[@]}"; do
    # Get IPv4 address
    ipv4=$(dig A +short $domain | tail -n 1) 
    if [[ -n $ipv4 ]]; then
        notify_block+=" $ipv4;"
        transfer_block+=" $ipv4;"
        notify_allow_block+=" $ipv4;"
    fi

    # Get IPv6 address
    ipv6=$(dig AAAA +short $domain | tail -n 1)
    if [[ -n $ipv6 ]]; then
        notify_block+=" $ipv6;"
        transfer_block+=" $ipv6;"
        notify_allow_block+=" $ipv6;"
    fi
done

# Close the configuration blocks
notify_block+=" };"
transfer_block+=" };"
notify_allow_block+=" };"

# Update BIND configuration file
# Make sure to backup the original file before modifying
sed -i "s/also-notify {.*};/$notify_block/" $namedPath
sed -i "s/allow-transfer {.*};/$transfer_block/" $namedPath
sed -i "s/allow-notify {.*};/$notify_allow_block/" $namedPath

```

Check NS of all your DirectAdmin domains (`check-ns.sh`):

```bash
#!/bin/bash

# Function to check DNS using dig
check_dns() {
    domain=$1
    echo "Checking NS for domain: $domain"
    dig +short $domain NS
    echo "------------------------------------"
}

# Read each domain from the output of the command and check its DNS
while IFS= read -r domain
do
    check_dns "$domain"
done < <(cat /etc/virtual/domainowners | cut -d ":" -f 1)
```

## Other info

Test DNS: https://manytools.org/network/query-dns-records-online/go

Test zone transfer: https://hackertarget.com/zone-transfer/

DNS check: http://dns-checker.online-domain-tools.com/

Domain Check: https://www.dnsqueries.com/en/domain_check.php

IntoDNS Test: https://intodns.com/

Change DNS: https://help.directadmin.com/item.php?id=141
