module Guidelines
  class ApproveByDeveloper
    include Command::Executable

    attribute :tid, String
    attribute :developer_id, String

    validates :tid, :developer_id, presence: true

    def call
      rfc = ObjectRepository.find(tid)
      rfc.approve_by!(developer_id)
    end
  end

  class IssueRequestForComment
    include Command::Message

    attribute :description, String
    attribute :developer_id, String

    validates :description, :developer_id, presence: true
  end

  class ApproveRequestForComment
    include Command::Message

    attribute :tid, String
    validates :tid, presence: true
  end
end
