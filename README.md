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
