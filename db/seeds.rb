# Seed two developers and one RFC through the command bus.
Command::Bus.new.call(Guidelines::IssueRequestForComment.new(
  description: "Adopt event-driven approval for RFCs",
  developer_id: "dev-1"
))
