class Song < ActiveRecord::Base
  belongs_to :uploader, class_name: 'User'
  belongs_to :release
  dragonfly_accessor :attachment

end
