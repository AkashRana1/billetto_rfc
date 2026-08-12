require "rails_helper"

RSpec.describe Guidelines::Service do
  it "issues an RFC and publishes an event" do
    generator = -> { "RFC-TEST-1" }
    service = described_class.new(generator)

    expect {
      service.send(:issue_rfc, Guidelines::IssueRequestForComment.new(
        description: "Test RFC",
        developer_id: "dev-1"
      ))
    }.to change(RfcEvent, :count).by(2)

    expect(Guidelines::RequestForComment.count).to eq(1)
  end
end
