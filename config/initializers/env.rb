APP_ENV = ENV['APP_ENV'] || ENV['RUBY_ENV'] || ENV['RAILS_ENV'] || 'development'
APP_ROOT = File.join(File.dirname(__FILE__), '../..' )

require 'bundler'
Bundler.require(:default, APP_ENV)
require_relative '../../app/tools/settings'
