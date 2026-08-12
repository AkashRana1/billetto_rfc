require_relative "application"
BillettoRfc::Application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.active_record.verbose_query_logs = true
end
