if Settings.has_key? 'newrelic' and Settings.newrelic.enabled
  GC::Profiler.enable
  require 'new_relic/control'
  NewRelic::Control.instance.init_plugin config_path: 'config/variables/newrelic.yml'
end
