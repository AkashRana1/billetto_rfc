require_relative "boot"
require "rails/all"
require_relative "../app/models/type_id"
# Dir[Rails.root.join("lib/**/*.rb")].sort.each { |file| require file }

Bundler.require(*Rails.groups)

module BillettoRfc
  class Application < Rails::Application
    config.load_defaults 7.2

    config.active_job.queue_adapter = :sidekiq
    config.clickup = ClickUp::Adapter.new(api_key: ENV["CLICKUP_API_KEY"])
  end
end
