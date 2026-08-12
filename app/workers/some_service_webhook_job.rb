class SomeServiceWebhookJob
  include Sidekiq::Job
  sidekiq_options queue: "critical"

  Error = Class.new(StandardError)

  def perform(webhook_id)
    IncomingWebhook.find(webhook_id).tap do |webhook|
      return if webhook.handled?
      handled = call(webhook.data.with_indifferent_access)
      webhook.mark_as_handled(Time.current, handled)
    end
  rescue StandardError => e
    raise Error, e.message
  end

  private

  def call(data)
    Rails.configuration.clickup.process_webhook(data)
    true
  end
end
