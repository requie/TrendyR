class Release < ActiveRecord::Base
  belongs_to :artist

  has_many :release_songs
  has_many :songs, through: :release_songs
end
