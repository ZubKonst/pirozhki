require 'yaml'

logstash_configs = YAML.load_file("#{APP_ROOT}/config/variables/logstash.yml")
logstash_config = logstash_configs[APP_ENV]

$logstash =
  if logstash_config[:type] == :stdout
    Logger.new(STDOUT)
  else
    LogStashLogger.new( logstash_config )
  end
