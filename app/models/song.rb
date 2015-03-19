class Song < ActiveRecord::Base
  belongs_to :uploader, class_name: 'User'

  has_many :release_songs
  has_many :releases, through: :release_songs
end
