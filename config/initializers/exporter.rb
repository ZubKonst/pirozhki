require 'yaml'

export_config = Settings.export

$exporter =
  case export_config.type
    when 'logstash_tcp'
      require 'logstash-logger'
      LogStashLogger.new(type: :tcp, host: export_config['host'], port: export_config['port'])
    else
      Logger.new(STDOUT)
  end
