require 'calabash-android/management/adb'
require 'calabash-android/operations'

Before do |scenario|
  if RunState.first_run?
    $stdout.write 'Initial app and test-server install... '
    reinstall_apps
    RunState.run!
  end
  start_test_server_in_background
end

After do |scenario|
  if scenario.failed?
    screenshot_embed
  end
  shutdown_test_server
end
