RUBY_ENV = ENV['RUBY_ENV'] || ENV['RAILS_ENV'] || 'development'
ENV['RAILS_ENV'] = ENV['RUBY_ENV'] = RUBY_ENV

require 'bundler'
Bundler.require(:default, RUBY_ENV)
