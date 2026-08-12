module ApplicationCommandHandlers
  module_function

  def registry
    @registry ||= {}
  end

  def register(handler_class)
    handler_class.handlers.each do |command_name, mapping|
      registry[command_name] = mapping
    end
  end

  def fetch(command_class)
    registry.fetch(command_class.name) { raise KeyError, "No handler for #{command_class.name}" }
  end
end
