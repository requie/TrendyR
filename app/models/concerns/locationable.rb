module Locationable
  extend ActiveSupport::Concern

  included do
    belongs_to :location
  end
end
