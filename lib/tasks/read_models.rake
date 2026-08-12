namespace :read_models do
  desc "Rebuild RFC issue counts from the event store"
  task rebuild_rfc_counts: :environment do
    ReadModels::NumberOfRfcIssuedByDeveloper::Count.delete_all

    RfcEvent.where(event_type: "Guidelines::RfcIssued").order(:id).group_by(&:event_id).each_value do |rows|
      row = rows.first
      fact = Guidelines::RfcIssued.strict(
        data: row.data.symbolize_keys,
        id: row.event_id,
        occurred_at: row.occurred_at
      )
      ReadModels::NumberOfRfcIssuedByDeveloper.new.call(fact)
    end

    puts "Read model rebuilt."
  end
end
