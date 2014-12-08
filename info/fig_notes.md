### Build images
```
docker run \
  --name pirozhki_db_volume \
  --volume /var/lib/postgresql/data \
  --volume /data  \
  ubuntu:14.04 true
fig build postgres redis web workers
```

### Setup pirozhki database
```
fig run -e APP_ENV=development --rm workers rake db:setup
```

### Run pirozhki tests
```
fig run -e APP_ENV=test -e COVERAGE=true --rm workers rspec
```

### Run pirozhki (web + workers)
```
fig up -d
```

### Run pirozhki web
```
fig start redis web
```

### Stop pirozhki (web + workers)
```
fig stop web workers
```

### Run pirozhki console (irb)
```
fig run -e APP_ENV=development --rm workers irb -r ./app.rb
```
