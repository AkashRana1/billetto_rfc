module TypeId
  def self.generate(prefix)
    "#{prefix}_#{SecureRandom.hex(10)}"
  end
end

module TypeIdExtension
  extend ActiveSupport::Concern

  included do
    before_validation :assign_type_id, on: :create
  end

  class_methods do
    def has_typeid(prefix)
      @typeid_prefix = prefix
    end

    def typeid_prefix
      @typeid_prefix
    end
  end

  def assign_type_id
    self.tid ||= TypeId.generate(self.class.typeid_prefix || "id")
  end
end

ActiveRecord::Base.include(TypeIdExtension)
