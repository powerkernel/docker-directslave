# docker-directslave

DirectSlave docker image

## RUN

```bash
docker compose up -d
```

## SSL

```bash
docker exec acme.sh --issue -d ns.hostname.com --dns dns_cf
docker exec acme.sh --deploy -d ns.hostname.com  --deploy-hook docker
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

## Other info

Test DNS: https://manytools.org/network/query-dns-records-online/go

Test zone transfer: https://hackertarget.com/zone-transfer/

DNS check: http://dns-checker.online-domain-tools.com/

Domain Check: https://www.dnsqueries.com/en/domain_check.php

IntoDNS Test: https://intodns.com/

Change DNS: https://help.directadmin.com/item.php?id=141
