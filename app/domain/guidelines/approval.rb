module Guidelines
  class Approval < ApplicationRecord
    self.table_name = "approvals"
    belongs_to :request_for_comment, foreign_key: :request_for_comment_id
  end
end
