module Guidelines
  def self.subscriptions
    [
      RfcApprovalProcess.subscriptions
    ].reduce(&:merge).merge(ReadModels::NumberOfRfcIssuedByDeveloper.subscriptions)
  end
end
