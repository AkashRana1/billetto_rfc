require_relative "boot"
require "rails/all"
require_relative "../app/models/type_id"
Dir[Rails.root.join("lib/**/*.rb")].sort.each { |file| require file }

Bundler.require(*Rails.groups)

module BillettoRfc
  class Application < Rails::Application
    config.load_defaults 7.2
    config.autoload_paths << Rails.root.join("app/domain")
    config.autoload_paths << Rails.root.join("app/read_models")
    config.autoload_paths << Rails.root.join("app/integrators")
    config.autoload_paths << Rails.root.join("app/integrations")
    config.eager_load_paths << Rails.root.join("app/domain")
    config.eager_load_paths << Rails.root.join("app/read_models")
    config.eager_load_paths << Rails.root.join("app/integrators")
    config.eager_load_paths << Rails.root.join("app/integrations")

    config.active_job.queue_adapter = :sidekiq
    config.clickup = ClickUp::Adapter.new(api_key: ENV["CLICKUP_API_KEY"])
  end
end
