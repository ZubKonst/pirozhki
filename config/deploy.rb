require 'yaml'

ENV['STAGE'] ||= 'production'
stage = ENV['STAGE']

require 'rvm/capistrano'
require 'bundler/capistrano'
require 'capistrano_colors'

deploy_configs = YAML.load_file(File.join(File.dirname(__FILE__), './variables/deploy.yml'))
deploy_config = deploy_configs[stage]

set :app_env, stage
set :domain, deploy_config[:domain]

set :application, 'pirozhki'
set :deploy_to, deploy_config[:deploy_to]
set :keep_releases, 3
set :normalize_asset_timestamps, false
set :shared_children, %w( log tmp/pids config/variables )

role :web, domain
role :app, domain, primary: true
role :db,  domain

set :rvm_ruby_string, deploy_config[:rvm_ruby_string]
set :rvm_type, :user
set :use_sudo, false

set :scm, :git
set :deploy_via, :remote_cache
set :repository, deploy_config[:repository]
set :branch, fetch(:branch, deploy_config[:branch])

set :god_config_file, "#{deploy_to}/current/config/god.rb"
set :god_port, 17770


namespace :deploy do
  task :restart do
    god_exec 'restart web'
    god_exec 'restart workers'
  end
  task :start do
    god_exec 'start web'
    god_exec 'start workers'
  end
  task :stop do
    god_exec 'stop web'
    god_exec 'stop workers'
  end
end

namespace :workers do
  task(:restart) { god_exec 'restart workers' }
  task(:start) { god_exec 'start workers' }
  task(:stop) { god_exec 'stop workers' }
end

namespace :web do
  task(:restart) { god_exec 'restart web' }
  task(:start) { god_exec 'start web' }
  task(:stop) { god_exec 'stop web' }
end


namespace :god do
  desc 'Stop god'
  task :stop do
    terminate_if_runing
  end

  desc 'Start god'
  task :start do
    god_start
  end
end


def god_is_running
  !capture("#{god_command} status >/dev/null 2>/dev/null || echo 'not running'").start_with?('not running')
end

def god_command
  "cd #{deploy_to}/current && bundle exec god -p #{god_port}"
end

def terminate_if_runing
  if god_is_running
    run "#{god_command} terminate"
  end
end

def god_start
  run "#{god_command} -c #{god_config_file}", env: { APP_ENV: app_env }
end

def god_exec(command)
  if god_is_running
    run "#{god_command} #{command}"
  else
    god_start
    run "#{god_command} #{command}"
  end
end
