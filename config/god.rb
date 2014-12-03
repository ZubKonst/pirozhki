require 'yaml'

@app_env = ENV['APP_ENV'] || 'production'

configs = YAML.load_file(File.join(File.dirname(__FILE__), './variables/application.yml'))
@app_path  = configs[@app_env]['app_path']
raise "Empty 'app_path' variable for #{@app_env}" unless @app_path

God.pid_file_directory = File.join(@app_path, 'tmp/pids/')

God.watch do |w|
  w.name = 'sidekiq_web'
  w.group    = 'web'
  w.interval = 30.seconds
  w.dir = @app_path
  w.env = { 'APP_ENV' => @app_env, 'BUNDLE_GEMFILE' => "#{@app_path}/Gemfile" }
  w.behavior(:clean_pid_file)

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds

  w.pid_file = "#{@app_path}/tmp/pids/sidekiq_web.pid"
  w.log = "#{@app_path}/log/god_sidekiq_web.log"

  w.start   = "cd #{@app_path} && bundle exec puma -C #{@app_path}/config/sidekiq_web.rb"
  w.stop    = "cd #{@app_path} && bundle exec pumactl -S #{@app_path}/tmp/pids/sidekiq_web.state stop"

  w.keepalive(interval: 5.seconds, memory_max: 300.megabytes, cpu_max: 80.percent)
end


God.watch do |w|
  sidekiq_worker_pid = "#{@app_path}/tmp/pids/sidekiq_worker.pid"

  w.name     = 'sidekiq_worker'
  w.group    = 'workers'
  w.dir      = @app_path
  w.interval = 30.seconds
  w.env      = { 'APP_ENV' => @app_env, 'BUNDLE_GEMFILE' => "#{@app_path}/Gemfile" }

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds

  w.pid_file = sidekiq_worker_pid
  w.log = "#{@app_path}/log/god_sidekiq_worker.log"

  w.start = "cd #{@app_path} && bundle exec sidekiq "+
    "-C #{@app_path}/config/variables/sidekiq.yml "+
    "-d -P #{sidekiq_worker_pid} "+
    "-r #{@app_path}/app.rb "+
    "-L #{@app_path}/log/sidekiq_worker.log "

  w.stop  = "cd #{@app_path} && bundle exec sidekiqctl quiet #{sidekiq_worker_pid} 10"

  w.keepalive(interval: 5.seconds, memory_max: 300.megabytes, cpu_max: 80.percent)
end

