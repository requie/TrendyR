class Profile < ActiveRecord::Base
  extend Photoable
  include Locationable

  belongs_to :user
  belongs_to :photo, class_name: 'Profile::Photo'
  belongs_to :wallpaper, class_name: 'Profile::Wallpaper'

  has_many :owned_events, class_name: 'Event', foreign_key: :owner_profile_id

  accepts_nested_attributes_for :photo, :wallpaper

  bind_photo_accessors :photo, :wallpaper

  # entity instance
  def entity
    user.entity_class.find_by_profile_id(id)
  end
end
