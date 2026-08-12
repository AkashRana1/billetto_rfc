module Handler
  module ClassMethods
    def subscribes_to(event_class)
      @subscribed_event = event_class
    end

    def subscriptions
      return {} unless @subscribed_event
      {
        @subscribed_event.name => [
          Handler::Subscription.new(@subscribed_event, self, async: @async, queue: @queue)
        ]
      }
    end
  end

  class Subscription
    def initialize(event_class, handler_class, async:, queue:)
      @event_class = event_class
      @handler_class = handler_class
      @async = async
      @queue = queue
    end

    def call(fact)
      if @async
        DomainEventJob.perform_async(@handler_class.name, fact.id)
      else
        @handler_class.new.call(fact)
      end
    end
  end

  def self.async(queue: "default")
    Module.new do
      define_method(:self) { self }
      included do |base|
        base.extend Handler::ClassMethods
        base.instance_variable_set(:@async, true)
        base.instance_variable_set(:@queue, queue)
      end
    end
  end
end
