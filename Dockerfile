FROM phusion/passenger-ruby21
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /pirozhki
WORKDIR /pirozhki/
ADD Gemfile /pirozhki/Gemfile
ADD Gemfile.lock /pirozhki/Gemfile.lock
RUN bundle install
ADD . /pirozhki
