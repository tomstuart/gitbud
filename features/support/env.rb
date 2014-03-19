require 'capybara/cucumber'
Capybara.app, _ = Rack::Builder.parse_file(File.expand_path('../../../config.ru', __FILE__))
