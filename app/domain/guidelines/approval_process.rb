module Guidelines
  class RfcApprovalProcess
    include Handler.async(queue: "low")
    subscribes_to RfcApprovedByDeveloper

    def initialize(approval_policy = JustEnoughApprovalPolicy.new)
      @approval_policy = approval_policy
    end

    def call(fact)
      tid = fact.data.fetch(:tid)
      approvals = event_store.read.stream("RFC$#{tid}").count do |event|
        event.type == RfcApprovedByDeveloper.name
      end

      if approval_policy.satisfied?(approvals)
        command_bus.call(ApproveRequestForComment.new(tid: tid))
      end
    end

    private

    attr_reader :approval_policy
  end
end
