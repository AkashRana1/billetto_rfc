require "active_model"

module Command
  class Message
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    def to_h
      attributes.symbolize_keys
    end
  end

  module Executable
    extend ActiveSupport::Concern
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::Validations

    included do
      def to_h
        attributes.symbolize_keys
      end
    end
  end

  module Handler
    extend ActiveSupport::Concern
    class_methods do
      def handles(command_class, method_name)
        handlers[command_class.name] = [self, method_name]
      end

      def handlers
        @handlers ||= {}
      end
    end
  end

  class Bus
    def initialize
      @correlation_id = nil
      @causation_id = nil
    end

    def call(command)
      raise ActiveModel::ValidationError, command unless command.valid?

      transaction do
        if command.is_a?(Command::Executable)
          execute(command)
        else
          execute_registered(command)
        end
      end
    end

    private

    def transaction
      ApplicationRecord.transaction { yield }
    end

    def execute(command)
      command.call
    end

    def execute_registered(command)
      handler, method_name = ApplicationCommandHandlers.fetch(command.class)
      instance = handler.new
      instance.public_send(method_name, command)
    end
  end
end
