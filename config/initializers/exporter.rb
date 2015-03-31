require 'yaml'

export_config = Settings.export.to_hash

$exporter =
  case export_config['type']
    when /\Alogstash_.+/
      require 'logstash-logger'
      export_config['type'].slice! 'logstash_'
      LogStashLogger.new export_config.symbolize_keys
    else
      Logger.new STDOUT
  end
