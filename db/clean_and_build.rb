def print_done(name)
  print "#{name}: "
  yield
  print "done.\n"
end

print_done 'Drop' do
  require_relative 'drop'
end
print_done 'Create' do
  require_relative 'create'
end
print_done 'Migrate' do
  require_relative 'migrate'
end
print_done 'Seed' do
  require_relative 'seed'
end
