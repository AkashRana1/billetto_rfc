require "rails_helper"

RSpec.describe Guidelines::RequestForComment do
  it "assigns a type id" do
    rfc = described_class.create!(number: "RFC-1", description: "Example", author_id: "dev-1")
    expect(rfc.tid).to start_with("rfc_")
  end
end
