class DomainEventJob
  include Sidekiq::Job
  sidekiq_options queue: "low"

  def perform(handler_name, event_id)
    event = RfcEvent.find_by!(event_id: event_id)
    fact_class = event.event_type.constantize
    fact = fact_class.strict(
      data: event.data.symbolize_keys,
      id: event.event_id,
      occurred_at: event.occurred_at,
      correlation_id: event.correlation_id,
      causation_id: event.causation_id
    )
    handler_name.constantize.new.call(fact)
  end
end
