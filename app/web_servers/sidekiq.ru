ENV['REDIS_NAMESPACE_QUIET'] = '1'
require_relative '../../app'

require 'sidekiq/web'
require 'sidekiq/cron/web'

map '/sidekiq' do
  if Settings.web.username && Settings.web.password
    use Rack::Auth::Basic, 'Protected Area' do |username, password|
      username == Settings.web.username.to_s &&
      password == Settings.web.password.to_s
    end
  end

  # https://github.com/mperham/sidekiq/issues/2555
  class SidekiqWeb < ::Sidekiq::Web
    set :session_secret, Settings.web.session_secret
    set :sessions, key: '_pirozhki'
    set :logging, Logger::DEBUG
  end

  run SidekiqWeb
end
