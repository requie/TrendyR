class Event < ActiveRecord::Base
  include Ownable
  include Locationable

  scope :ordered, -> { order(:started_at) }
end
