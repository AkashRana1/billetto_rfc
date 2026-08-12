require_relative "application"
BillettoRfc::Application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.active_job.queue_adapter = :inline
end
