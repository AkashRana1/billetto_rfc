class SomeNumberGenerator
  def call
    "RFC-#{Time.current.strftime('%Y%m%d')}-#{RfcNumberSequence.create!.id.to_s.rjust(4, '0')}"
  end
end
