module EventStoreInjector
  extend ActiveSupport::Concern

  included do
    after_initialize :inject_event_store
  end

  def event_store
    @event_store ||= EventStore.new
  end

  private

  def inject_event_store
    @event_store = EventStore.new
  end
end
