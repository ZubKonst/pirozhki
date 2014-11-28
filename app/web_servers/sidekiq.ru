ENV['REDIS_NAMESPACE_QUIET'] = '1'
require_relative '../../app'

require 'sidekiq/web'
require 'sidetiq/web'

map '/' do
  if Settings.web['username'] && Settings.web['password']
    use Rack::Auth::Basic, 'Protected Area' do |username, password|
      (username == Settings.web['username'].to_s) &&
      (password == Settings.web['password'].to_s)
    end
  end

  run Sidekiq::Web
end
