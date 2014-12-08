require 'yaml'
require_relative 'initializers/env'

environment APP_ENV

directory APP_ROOT
rackup "#{APP_ROOT}/app/web_servers/sidekiq.ru"

pidfile "#{APP_ROOT}/tmp/pids/sidekiq_web.pid"
state_path "#{APP_ROOT}/tmp/pids/sidekiq_web.state"

logging_config = Settings.logging

case logging_config.type
  when 'file'
    stdout_redirect "#{APP_ROOT}/log/sidekiq_web_stdout.log", "#{APP_ROOT}/log/sidekiq_web_stderr.log"
  else
    nil #STDOUT
end

threads 1, 2
bind 'tcp://0.0.0.0:3000'
# bind "unix:///#{@app_path}/tmp/pids/sidekiq_web.sock"
