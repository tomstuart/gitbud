require 'capybara/cucumber'
Capybara.app, _ = Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__))

require 'rspec'
RSpec.configure do |config|
  config.deprecation_stream = '/dev/null'
end
