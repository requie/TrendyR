module Ownable
  extend ActiveSupport::Concern

  included do
    belongs_to :owner_profile, class_name: 'Profile'
  end
end
