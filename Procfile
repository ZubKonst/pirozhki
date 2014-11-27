web: puma -t 1:2 -b tcp://0.0.0.0:3000 app/web_servers/sidekiq.ru
workers: sidekiq -r ./app.rb -C config/variables/sidekiq_worker.yml
