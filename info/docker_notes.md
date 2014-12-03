### Create pirozhki_db_volume
```
docker run \
  --name pirozhki_db_volume \
  --volume /var/lib/postgresql/data \
  --volume /data  \
  ubuntu:14.04 true
```

### Run pirozhki_db_volume console
```
docker run \
  --volumes-from pirozhki_db_volume \
  -it \
  --rm=true \
  ubuntu:14.04 /bin/bash
```

### Run postgres
```
docker run \
  --name pirozhki_postgres \
  --volumes-from pirozhki_db_volume \
  -e POSTGRES_USER=pirozhki \
  -e POSTGRES_PASSWORD=mysecretpassword \
  -d \
  postgres:9.3
```

### Run postgres console
```
docker run \
  --link pirozhki_postgres:postgres \
  -it \
  --rm=true \
  postgres:9.3 sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U pirozhki'
```

### Run redis
```
docker run \
  --name pirozhki_redis \
  --volumes-from pirozhki_db_volume \
  -d \
  redis:2.8 redis-server --appendonly yes
```


### Run redis console
```
docker run \
  --link pirozhki_redis:redis \
  -it \
  --rm=true \
  redis sh -c 'exec redis-cli -h "$REDIS_PORT_6379_TCP_ADDR" -p "$REDIS_PORT_6379_TCP_PORT"'
```

### Build pirozhki image
```
docker build -t="zubkonst/pirozhki:latest" .
```

### Init pirozhki database
```
docker run \
  --link pirozhki_postgres:postgres \
  -e APP_ENV=development \
  --rm=true \
  zubkonst/pirozhki rake db:setup
```


### Run pirozhki console
```
docker run \
  --link pirozhki_redis:redis \
  --link pirozhki_postgres:postgres \
  -e APP_ENV=development \
  -it \
  --rm=true \
  zubkonst/pirozhki irb -r ./app.rb
```

### Run pirozhki rspec
```
docker run \
  --link pirozhki_postgres:postgres \
  -e APP_ENV=test \
  -e COVERAGE=true \
  -it \
  --rm=true \
  zubkonst/pirozhki rspec
```

### Run pirozhki web
```
docker run \
  --name pirozhki_web \
  --link pirozhki_redis:redis \
  -e APP_ENV=development \
  -p 9292:9292 \
  -d \
  zubkonst/pirozhki puma -C config/sidekiq_web.rb
```

### Run pirozhki workers
```
docker run \
  --name pirozhki_workers \
  --link pirozhki_postgres:postgres \
  --link pirozhki_redis:redis \
  -e APP_ENV=development \
  -d \
  zubkonst/pirozhki sidekiq -r ./app.rb -C config/variables/sidekiq.yml
```

