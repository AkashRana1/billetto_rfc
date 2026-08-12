module Guidelines
  class RfcIssued < Fact
    SCHEMA = {
      tid: String,
      developer_id: String,
      number: String
    }.freeze

    def stream_names
      ["RFC$#{data.fetch(:tid)}", "Developer$#{data.fetch(:developer_id)}"]
    end
  end

  class RfcApprovedByDeveloper < Fact
    SCHEMA = {
      tid: String,
      developer_id: String
    }.freeze

    def stream_names
      ["RFC$#{data.fetch(:tid)}", "Developer$#{data.fetch(:developer_id)}"]
    end
  end

  class RfcApproved < Fact
    SCHEMA = { tid: String }.freeze

    def stream_names
      ["RFC$#{data.fetch(:tid)}"]
    end
  end
end
