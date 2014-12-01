FROM phusion/passenger-ruby21
MAINTAINER Konstantin Zub "hello@zubkonst.com"

CMD ["/sbin/my_init"]

#RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN rm -f /etc/service/nginx/down
ADD config/nginx/sidekiq.conf /etc/nginx/sites-enabled/sidekiq.conf

RUN mkdir /home/app/pirozhki
WORKDIR /home/app/pirozhki/

ADD Gemfile /home/app/pirozhki/Gemfile
ADD Gemfile.lock /home/app/pirozhki/Gemfile.lock
RUN bundle install

ADD . /home/app/pirozhki

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
