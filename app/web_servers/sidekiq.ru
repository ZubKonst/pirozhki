ENV['REDIS_NAMESPACE_QUIET'] = '1'
require_relative '../../app'

require 'sidekiq/web'
require 'sidetiq/web'

map '/sidekiq' do
  if defined?(SIDEKIQ_WEB) && SIDEKIQ_WEB[:user] && SIDEKIQ_WEB[:pass]
    use Rack::Auth::Basic, 'Protected Area' do |username, password|
      username == SIDEKIQ_WEB[:user] && password == SIDEKIQ_WEB[:pass]
    end
  end

  run Sidekiq::Web
end
