class ObjectRepository
  TYPE_MAP = {
    "rfc" => Guidelines::RequestForComment
  }.freeze

  def self.find(tid)
    prefix = tid.to_s.split("_", 2).first
    klass = TYPE_MAP.fetch(prefix) { raise ActiveRecord::RecordNotFound, "Unknown type id: #{tid}" }
    klass.find_by!(tid: tid)
  end
end
