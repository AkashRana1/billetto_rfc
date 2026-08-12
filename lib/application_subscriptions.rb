class ApplicationSubscriptions
  def self.handlers
    {}.merge(Guidelines.subscriptions).merge(GuidelinesIntegrators.subscriptions)
  end

  def self.dispatch(fact)
    handlers.fetch(fact.class.name, []).each { |subscription| subscription.call(fact) }
  end
end
