class Profile < ActiveRecord::Base
  extend Photoable
  include Locationable

  %w(artist label manager producer venue).each do |type|
    update_index("search##{type}") { entity if entity.class.to_s.downcase == type }
  end

  OWNED_OBJECTS = %i(photo_albums events gigs awards)

  belongs_to :user
  belongs_to :photo, class_name: 'Profile::Photo'
  belongs_to :wallpaper, class_name: 'Profile::Wallpaper'

  has_many :owned_events, -> { order(:started_at) }, class_name: 'Event', foreign_key: :owner_profile_id
  has_many :owned_gigs, -> { order(:started_at) }, class_name: 'Gig', foreign_key: :owner_profile_id
  has_many :owned_awards, -> { order(:earned_at) }, class_name: 'Award', foreign_key: :owner_profile_id
  has_many :genre_profiles
  has_many :genres, through: :genre_profiles
  has_many :owned_photo_albums, -> { order(:created_at) }, class_name: 'PhotoAlbum', foreign_key: :owner_profile_id

  accepts_nested_attributes_for :photo, :wallpaper

  bind_photo_accessors :photo, :wallpaper

  # entity instance
  def entity
    user.entity_class.find_by(profile_id: id)
  end

  OWNED_OBJECTS.each do |object|
    define_method("filter_#{object}") do |ids|
      send("owned_#{object}").where(id: ids)
    end

    define_method("delete_#{object}") do |ids|
      send("filter_#{object}", ids).destroy_all
    end
  end
end
