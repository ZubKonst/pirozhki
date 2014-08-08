RUBY_ENV = ENV['RUBY_ENV'] || 'development'

require 'bundler'
Bundler.require(:default)

require 'yaml'
require 'set'
