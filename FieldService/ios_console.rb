require 'pry'
require 'calabash-cucumber/operations'

extend Calabash::Cucumber::Operations

APP_BUNDLE_PATH='ios-source/3.3.1/build/Applications/WordPress.app'

def embed(*args)
end

self.pry
