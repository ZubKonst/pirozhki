require 'yaml'

if Sidekiq.server?
  schedule_configs = YAML.load_file "#{APP_ROOT}/config/variables/sidekiq_cron.yml"
  schedule_config  = schedule_configs[APP_ENV]
  raise "Empty schedule_config for #{APP_ENV}" unless schedule_config

  Sidekiq::Cron::Job.load_from_hash! schedule_config
end
