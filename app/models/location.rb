class Location < ActiveRecord::Base
  SOURCE_GOOGLE = 'google'

  has_one :profile
  belongs_to :creator, class_name: 'User'

  validates :source, :source_id, :source_place_id, :address, :types, presence: true
  validates :longitude, :latitude, numericality: true, presence: true
end
