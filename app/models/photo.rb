class Photo < ActiveRecord::Base
  delegate :thumb, to: :attachment
  dragonfly_accessor :attachment
  has_many :photo_album_photos
  has_many :photo_albums, through: :photo_album_photos
  belongs_to :uploader, class_name: 'User'

  def cropped_photo
    attachment.thumb("#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}")
  end

  # redifine the method in child classes to contain presets
  # {
  #   tiny: '100x100#',
  #   big: '500x500'
  # }
  def presets
    {}
  end
end
