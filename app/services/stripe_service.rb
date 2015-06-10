class StripeService
  def self.call(*params)
    self.new.call(*params)
  end

  def call(*params)
    raise NotImplementedError.new
  end
end
