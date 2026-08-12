require "rails_helper"

RSpec.describe Guidelines::JustEnoughApprovalPolicy do
  it "requires two approvals" do
    policy = described_class.new
    expect(policy.satisfied?(1)).to be(false)
    expect(policy.satisfied?(2)).to be(true)
  end
end
