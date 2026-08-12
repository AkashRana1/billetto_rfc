require_relative "application"
BillettoRfc::Application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.log_level = :info
end
