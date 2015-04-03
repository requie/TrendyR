class Profile < ActiveRecord::Base
  extend Photoable
  include Locationable

  belongs_to :user
  belongs_to :photo, class_name: 'Profile::Photo'
  belongs_to :wallpaper, class_name: 'Profile::Wallpaper'

  has_many :owned_events, -> { order(:started_at) }, class_name: 'Event', foreign_key: :owner_profile_id
  has_many :owned_gigs, -> { order(:started_at) }, class_name: 'Gig', foreign_key: :owner_profile_id
  has_many :owned_awards, -> { order(:earned_at) }, class_name: 'Award', foreign_key: :owner_profile_id
  has_many :genre_profiles
  has_many :genres, through: :genre_profiles
  has_many :owned_photo_albums, -> { order(:created_at) }, class_name: 'PhotoAlbum', foreign_key: :owner_profile_id
  has_many :owned_releases, class_name: 'Release', foreign_key: :owner_profile_id

  accepts_nested_attributes_for :photo, :wallpaper

  bind_photo_accessors :photo, :wallpaper

  # entity instance
  def entity
    user.entity_class.find_by(profile_id: id)
  end

  def filter_photo_albums(photo_album_ids)
    owned_photo_albums.where(id: photo_album_ids)
  end
end
