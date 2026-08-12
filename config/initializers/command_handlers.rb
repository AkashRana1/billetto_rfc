Rails.application.config.to_prepare do
  ApplicationCommandHandlers.register(Guidelines::Service)
  ApplicationCommandHandlers.register(ClickUp::Service)
end
