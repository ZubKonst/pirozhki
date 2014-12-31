Pirozhki
========
[![Build Status](https://travis-ci.org/ZubKonst/pirozhki.svg?branch=master)](https://travis-ci.org/ZubKonst/pirozhki)
[![Dependency Status](https://gemnasium.com/ZubKonst/pirozhki.svg)](https://gemnasium.com/ZubKonst/pirozhki)
[![Code Climate](https://codeclimate.com/github/ZubKonst/pirozhki/badges/gpa.svg)](https://codeclimate.com/github/ZubKonst/pirozhki)
[![Coverage Status](https://coveralls.io/repos/ZubKonst/pirozhki/badge.png?branch=master)](https://coveralls.io/r/ZubKonst/pirozhki)

Pirozhki is a [sidekiq](http://sidekiq.org)-based utility for collecting data from social networks. 

##Available types of Pirozhki:
- Pirozhki with instagram and geotags. (GeoPoint table.)

##Useful examples:
- Real life demo: http://pirozhki.zubkonst.com

##Run Pirozhki in Docker container:
- Visit [Pirozhki-docker](https://github.com/ZubKonst/pirozhki-docker)

##Run Pirozhki locally:
- Copy all files from `APP/config/variables/sample/` to `APP/config/variables/` and fill with your data.
- Init database:
```
[APP_ENV=development] rake db:create
[APP_ENV=development] rake db:migrate
[APP_ENV=development] rake db:seed
```
- Use [foreman](https://github.com/ddollar/foreman) or run manually:
```
web: puma app/web_servers/sidekiq.ru
worker: sidekiq -r ./app.rb -C config/variables/sidekiq.yml
```
- Run console:
```
[APP_ENV=development] irb -r ./app.rb
```

##License:
Pirozhki is a utility for collecting data from social networks.  
Copyright (C) 2014  Konstantin Zub (hello at zubkonst.com)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
