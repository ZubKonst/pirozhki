require 'yaml'

module Sidekiq
  def self.load_json(string)
    Oj.load(string)
  rescue
    JSON.parse(string)
  end

  def self.dump_json(object)
    Oj.dump(object, mode: :compat)
  rescue
    JSON.generate(object)
  end
end

sidekiq_web_configs = YAML.load_file(File.join(File.dirname(__FILE__), '../variables/sidekiq_web.yml'))

sidekiq_web_config = sidekiq_web_configs[RUBY_ENV]
SIDEKIQ_WEB = { user: sidekiq_web_config[:username], pass: sidekiq_web_config[:password] }

Sidekiq.default_worker_options = { 'backtrace' => true }

Sidekiq.configure_client do |config|
  config.redis = { namespace: 'pirozhki' }
end

Sidekiq.configure_server do |config|
  config.redis = { namespace: 'pirozhki' }
  config.poll_interval = 15
  config.server_middleware do |chain|
    chain.add Sidekiq::Throttler, storage: :redis
  end
end

