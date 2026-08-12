class Fact
  attr_reader :data, :id, :occurred_at, :correlation_id, :causation_id

  def self.strict(data:, id: SecureRandom.uuid, occurred_at: Time.current, correlation_id: nil, causation_id: nil)
    validate_schema!(data)
    new(data: data, id: id, occurred_at: occurred_at, correlation_id: correlation_id, causation_id: causation_id)
  end

  def self.validate_schema!(data)
    schema = const_get(:SCHEMA)
    schema.each do |key, type|
      value = data[key]
      raise ArgumentError, "Missing #{key}" if value.nil?
      raise ArgumentError, "#{key} must be #{type}" unless value.is_a?(type)
    end
  end

  def initialize(data:, id:, occurred_at:, correlation_id:, causation_id:)
    @data = data.deep_symbolize_keys
    @id = id
    @occurred_at = occurred_at
    @correlation_id = correlation_id
    @causation_id = causation_id
  end
end
