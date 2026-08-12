ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rspec/rails"
require "factory_bot_rails"

abort("The Rails environment is running in production mode!") if Rails.env.production?

RSpec.configure do |config|
  config.use_transactional_fixtures = true
end
