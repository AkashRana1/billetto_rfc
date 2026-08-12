class EventStore
  Reader = Struct.new(:events) do
    def stream(name)
      events.select { |event| event.stream_names.include?(name) }
    end
  end

  def publish(fact)
    fact.stream_names.each do |stream_name|
      RfcEvent.create!(
        event_id: fact.id,
        event_type: fact.class.name,
        stream_name: stream_name,
        data: fact.data,
        correlation_id: fact.correlation_id,
        causation_id: fact.causation_id,
        occurred_at: fact.occurred_at
      )
    end

    ApplicationSubscriptions.dispatch(fact)
    fact
  end

  def read
    rows = RfcEvent.order(:id).to_a
    facts = rows.group_by(&:event_id).map do |_id, group|
      row = group.first
      klass = row.event_type.constantize
      klass.strict(
        data: row.data.symbolize_keys,
        id: row.event_id,
        occurred_at: row.occurred_at,
        correlation_id: row.correlation_id,
        causation_id: row.causation_id
      )
    end
    Reader.new(facts)
  end
end
