require "rails_helper"

RSpec.describe "RFC API", type: :request do
  it "creates an RFC through the command bus" do
    post "/rfcs", params: { description: "Example", developer_id: "dev-1" }
    expect(response).to have_http_status(:accepted)
    expect(Guidelines::RequestForComment.count).to eq(1)
  end
end
