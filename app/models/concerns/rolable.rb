module Rolable
  extend ActiveSupport::Concern

  included do
    belongs_to :profile
    delegate :user, to: :profile
  end
end
