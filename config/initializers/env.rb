APP_ENV = ENV['APP_ENV'] || ENV['RUBY_ENV'] || 'development'
ENV['APP_ENV']  ||= APP_ENV
ENV['RUBY_ENV'] ||= APP_ENV

current_file_dir = File.dirname __FILE__
APP_ROOT = File.join current_file_dir, '../..'

require 'bundler'
Bundler.require :default, APP_ENV
require_relative '../../app/tools/settings'
