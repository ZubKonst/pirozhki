logstash_configs = YAML.load_file(File.join(File.dirname(__FILE__), '../variables/logstash.yml'))
logstash_config = logstash_configs[RUBY_ENV]

if logstash_config[:type] == :stdout
  $logstash = Logger.new(STDOUT)
else
  $logstash = LogStashLogger.new( logstash_config )
end
