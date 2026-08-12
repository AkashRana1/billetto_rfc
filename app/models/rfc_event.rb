class RfcEvent < ApplicationRecord
  self.table_name = "rfc_event_stores"
  serialize :data, coder: JSON
end
