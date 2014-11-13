Pirozhki
========
[![Build Status](https://travis-ci.org/ZubKonst/pirozhki.svg?branch=master)](https://travis-ci.org/ZubKonst/pirozhki)
[![Dependency Status](https://gemnasium.com/ZubKonst/pirozhki.svg)](https://gemnasium.com/ZubKonst/pirozhki)
[![Code Climate](https://codeclimate.com/github/ZubKonst/pirozhki/badges/gpa.svg)](https://codeclimate.com/github/ZubKonst/pirozhki)
[![Coverage Status](https://coveralls.io/repos/ZubKonst/pirozhki/badge.png?branch=master)](https://coveralls.io/r/ZubKonst/pirozhki)

Pirozhki is a [sidekiq](http://sidekiq.org)-based utility for collecting data from social networks. 

Available types of Pirozhki:
--
- Pirozhki with instagram and geotags. (GeoPoint table.)

Useful examples:
--
- Connecting with ELK (Elasticsearch, Logstash and Kibana) stack.
  - Posts over time ![Images over time](info/images_over_time.png)
  - Posts on the map ![Images on the map](info/images_on_the_map.png)  
  - Hashtags by popularity ![Hashtags and Places](info/hashtags_by_popularity.png)  


Run Pirozhki on the server:
--
- Fill with your data configs from `APP/config/variables/...` and put configs into server `{deploy_dir}/shared/variables`  
- Fill with your data `deploy_sample.yml`, rename to `deploy.yml` and use capistrano. `/config/variables/deploy.yml` is gitignored.
- Capistrano tips:
```
cap deploy:start (restart|stop)
cap sidekiq_web:start (restart|stop)
cap sidekiq_workers:start (restart|stop)
```

Run Pirozhki locally:
--
- Fill with your data configs from `APP/config/variables/...`
- Enjoy [foreman](https://github.com/ddollar/foreman).

Init database on the server from project path:
--
```
[RUBY_ENV=production] ruby db/create.rb
[RUBY_ENV=production] ruby db/migrate.rb
[RUBY_ENV=production] ruby db/seed.rb
```

Run console:
--
```
[RUBY_ENV=production] bundle exec irb -r ./app.rb
```
