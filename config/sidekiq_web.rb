require 'yaml'

@app_env = ENV['APP_ENV'] || 'production'
environment @app_env

configs = YAML.load_file(File.join(File.dirname(__FILE__), './variables/application.yml'))
@app_path = configs[@app_env]['app_path']
raise "Empty 'app_path' variable for #{@app_env}" unless @app_path


directory @app_path
rackup "#{@app_path}/app/web_servers/sidekiq.ru"

pidfile "#{@app_path}/tmp/pids/sidekiq_web.pid"
state_path "#{@app_path}/tmp/pids/sidekiq_web.state"
stdout_redirect "#{@app_path}/log/sidekiq_web_stdout.log", "#{@app_path}/log/sidekiq_web_stderr.log"

threads 1, 2
bind "unix:///#{@app_path}/tmp/pids/sidekiq_web.sock"
