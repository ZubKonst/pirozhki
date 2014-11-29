class Settings < Settingslogic
  source "#{APP_ROOT}/config/variables/application.yml"
  namespace APP_ENV
  load!
end