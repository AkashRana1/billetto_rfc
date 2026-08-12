module GuidelinesIntegrators
  def self.subscriptions
    [ScheduleCodeRefactorWhenRfcApproved.subscriptions].reduce(&:merge)
  end

  class ScheduleCodeRefactorWhenRfcApproved
    include Handler.async(queue: "low")
    subscribes_to Guidelines::RfcApproved

    def call(fact)
      rfc = ObjectRepository.find(fact.data.fetch(:tid))
      Command::Bus.new.call(
        ClickUp::AddNewTaskToTheBacklog.new(**build_task(rfc))
      )
    end

    private

    def build_task(rfc)
      {
        tid: rfc.tid,
        title: "Refactor #{rfc.number}",
        description: rfc.description
      }
    end
  end
end
