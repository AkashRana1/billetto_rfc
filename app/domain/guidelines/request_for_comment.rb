module Guidelines
  class RequestForComment < ApplicationRecord
    self.table_name = "request_for_comments"
    include EventStoreInjector

    has_typeid :rfc
    has_many :approvals, dependent: :destroy

    def approve_by!(developer_id)
      approvals.create!(developer_id: developer_id)
      event_store.publish(
        RfcApprovedByDeveloper.strict(data: { tid: tid, developer_id: developer_id })
      )
    end

    def approve!
      event_store.publish(RfcApproved.strict(data: { tid: tid }))
    end
  end
end
