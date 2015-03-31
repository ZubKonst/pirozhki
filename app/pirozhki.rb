dirs = %w[ models record_builders social_clients workers tools ]

current_file_dir = File.dirname __FILE__
dirs.each do |dir|
  require_dir = File.join current_file_dir , dir, '*.rb'
  Dir[require_dir].each { |file| require file }
end
