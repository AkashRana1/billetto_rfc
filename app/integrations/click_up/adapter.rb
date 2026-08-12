module ClickUp
  class Adapter
    def initialize(api_key:)
      @api_key = api_key
    end

    def add_task(title:, description:)
      Rails.logger.info("[ClickUp] add_task title=#{title.inspect} description=#{description.inspect}")
      { "id" => SecureRandom.hex(6), "title" => title }
    end

    def process_webhook(data)
      Rails.logger.info("[ClickUp] webhook=#{data.inspect}")
      true
    end

    private

    attr_reader :api_key
  end
end
