require 'yaml'

ENV['RUBY_ENV'] ||= 'production'
environment ENV['RUBY_ENV']

sidekiq_web_configs = YAML.load_file(File.join(File.dirname(__FILE__), './variables/sidekiq_web.yml'))
sidekiq_web_config = sidekiq_web_configs[ENV['RUBY_ENV']]
app_path = sidekiq_web_config[:app_path]

directory app_path
rackup "#{app_path}/app/web_servers/sidekiq.ru"

pidfile "#{app_path}/tmp/pids/sidekiq_web.pid"
state_path "#{app_path}/tmp/pids/sidekiq_web.state"
stdout_redirect "#{app_path}/log/sidekiq_web_stdout.log", "#{app_path}/log/sidekiq_web_stderr.log"

threads 0, 2
bind "unix:///#{app_path}/tmp/pids/sidekiq_web.sock"
