sidekiq_web: puma -t 1:2 -b tcp://0.0.0.0:3000 app/web_servers/sidekiq.ru

sidekiq_manager: sidekiq -r ./app.rb -C config/variables/sidekiq_manager.yml
sidekiq_api:     sidekiq -r ./app.rb -C config/variables/sidekiq_api.yml
sidekiq_db:      sidekiq -r ./app.rb -C config/variables/sidekiq_db.yml
sidekiq_export:  sidekiq -r ./app.rb -C config/variables/sidekiq_export.yml
