### Build images
```
fig build dbvolume postgres redis web workers
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
fig up web workers
```

### Run pirozhki console (irb)
```
fig run -e APP_ENV=development --rm workers irb -r ./app.rb
```
