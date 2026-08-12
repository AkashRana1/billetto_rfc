class IncomingWebhook < ApplicationRecord
  serialize :data, coder: JSON

  def handled?
    handled_at.present?
  end

  def mark_as_handled(time, result)
    update!(handled_at: time, handled_result: result)
  end
end
