class Location < ActiveRecord::Base
  SOURCE_GOOGLE = 'google'

  %w(artist label manager producer venue).each do |type|
    update_index("search##{type}") { entities(type) }
  end

  has_many :profiles
  belongs_to :creator, class_name: 'User'

  validates :source, :source_id, :source_place_id, :address, :types, presence: true
  validates :longitude, :latitude, numericality: true, presence: true

  private

  def entities(type)
    profiles.select { |e| e.class.to_s.downcase == type }
  end
end
