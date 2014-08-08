@ruby_env = ENV['RUBY_ENV'] || 'production'

god_configs = YAML.load_file(File.join(File.dirname(__FILE__), './variables/god.yml'))
god_config = god_configs[@ruby_env]
@app_path  = god_config[:app_path]

God.pid_file_directory = File.join(@app_path, 'tmp/pids/')

God.watch do |w|
  w.name = 'sidekiq_puma'
  w.group    = 'sidekiq_web'
  w.interval = 30.seconds
  w.dir = @app_path
  w.env = { 'RUBY_ENV' => @ruby_env, 'BUNDLE_GEMFILE' => "#{@app_path}/Gemfile" }
  w.behavior(:clean_pid_file)

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds

  w.pid_file = "#{@app_path}/tmp/pids/sidekiq_web.pid"
  w.log = "#{@app_path}/log/god_sidekiq_web.log"

  w.start   = "cd #{@app_path} && bundle exec puma -C #{@app_path}/config/sidekiq_web.rb"
  w.stop    = "cd #{@app_path} && bundle exec pumactl -S #{@app_path}/tmp/pids/sidekiq_web.state stop"

  w.keepalive(interval: 5.seconds, memory_max: 300.megabytes, cpu_max: 80.percent)
end



sidekiq_workers = %w[ sidekiq_manager sidekiq_api sidekiq_db sidekiq_export ]

sidekiq_workers.each do |sidekiq_worker|
  sidekiq_worker_pid = "#{@app_path}/tmp/pids/#{sidekiq_worker}.pid"

  God.watch do |w|
    w.name     = sidekiq_worker
    w.group    = 'sidekiq_workers'
    w.dir      = @app_path
    w.interval = 30.seconds
    w.env      = { 'RUBY_ENV' => @ruby_env, 'BUNDLE_GEMFILE' => "#{@app_path}/Gemfile" }

    w.start_grace = 10.seconds
    w.restart_grace = 10.seconds

    w.pid_file = sidekiq_worker_pid
    w.log = "#{@app_path}/log/god_#{sidekiq_worker}.log"

    w.start = "cd #{@app_path} && bundle exec sidekiq "+
      "-C #{@app_path}/config/variables/#{sidekiq_worker}.yml "+
      "-d -P #{sidekiq_worker_pid} "+
      "-r #{@app_path}/app.rb " +
      "-L #{@app_path}/log/#{sidekiq_worker}.log "

    w.stop  = "cd #{@app_path} && bundle exec sidekiqctl quiet #{sidekiq_worker_pid} 10"

    w.keepalive(interval: 5.seconds, memory_max: 300.megabytes, cpu_max: 80.percent)
  end
end

