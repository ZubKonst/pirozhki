RUBY_ENV = ENV['RUBY_ENV'] || 'development'

require 'bundler'
Bundler.require(:default, RUBY_ENV)

require 'yaml'
require 'set'
