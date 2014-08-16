logstash_configs = YAML.load_file(File.join(File.dirname(__FILE__), '../variables/logstash.yml'))
logstash_config = logstash_configs[RUBY_ENV]

$logstash =
  if logstash_config[:type] == :stdout
    Logger.new(STDOUT)
  else
    LogStashLogger.new( logstash_config )
  end
