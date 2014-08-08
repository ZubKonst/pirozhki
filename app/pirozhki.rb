dirs = %w[ models record_builders social_clients workers ]

dirs.each do |dir|
  Dir[File.join(File.dirname(__FILE__), dir, '*.rb')].each { |file| require file }
end
