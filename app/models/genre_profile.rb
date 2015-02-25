class GenreProfile < ActiveRecord::Base
  self.table_name = 'genres_profiles'

  belongs_to :genre
  belongs_to :profile
end
