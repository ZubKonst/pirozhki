ENV['REDIS_NAMESPACE_QUIET'] = '1'
require_relative '../../app'

require 'sidekiq/web'
require 'sidekiq/cron/web'

if Settings.web.username && Settings.web.password
  use Rack::Auth::Basic, 'Protected Area' do |username, password|
    username == Settings.web.username.to_s &&
      password == Settings.web.password.to_s
  end
end

# https://github.com/mperham/sidekiq/issues/2555
use Rack::Session::Cookie, key: 'pirozhki.session', secret: Settings.web.session_secret
class SidekiqWeb < ::Sidekiq::Web
  disable :sessions
end

run SidekiqWeb
