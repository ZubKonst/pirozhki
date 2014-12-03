###Create pirozhki_db_volume
```
docker run \
  --name pirozhki_db_volume \
  --volume /var/lib/postgresql/data \
  --volume /data  \
  ubuntu:14.04 true
```

###Connect to pirozhki_db_volume
```
docker run \
  --volumes-from pirozhki_db_volume \
  -it \
  --rm=true \
  ubuntu:14.04 /bin/bash
```

###Run postgres
```
docker run \
  --name pirozhki_postgres \
  --volumes-from pirozhki_db_volume \
  -e POSTGRES_USER=pirozhki \
  -e POSTGRES_PASSWORD=mysecretpassword \
  -d \
  postgres:9.3
```

###Connect to postgres
```
docker run \
  --link pirozhki_postgres:postgres \
  -it \
  --rm=true \
  postgres:9.3 sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U pirozhki'
```

###Run redis
```
docker run \
  --name pirozhki_redis \
  --volumes-from pirozhki_db_volume \
  -d \
  redis:2.8 redis-server --appendonly yes
```


###Connect to redis
```
docker run \
  --link pirozhki_redis:redis \
  -it \
  --rm=true \
  redis sh -c 'exec redis-cli -h "$REDIS_PORT_6379_TCP_ADDR" -p "$REDIS_PORT_6379_TCP_PORT"'
```

### Build pirozhki image
```
docker build -t="zubkonst/pirozhki:v0.2.3" .
```
