web: puma -t 1:2 -b tcp://0.0.0.0:3000 app/web_servers/sidekiq.ru
worker: sidekiq -r ./app.rb -C config/variables/sidekiq.yml
