class Genre < ActiveRecord::Base
  ALL = %w(Reggae Dancehall Soca Calipso Rocksteady Gospel-Reggae Reggae-pop)
  has_many :genre_profile
  has_many :profiles, through: :genre_profile

  validates :name, presence: true
end
