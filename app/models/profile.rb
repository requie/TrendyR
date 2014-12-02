class Profile < ActiveRecord::Base
  belongs_to :photo, class_name: 'Profile::Photo'
  belongs_to :wallpaper, class_name: 'Profile::Wallpaper'
  accepts_nested_attributes_for :photo, :wallpaper
end
