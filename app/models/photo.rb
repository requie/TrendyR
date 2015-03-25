class Photo < ActiveRecord::Base
  GALLERY_PHOTO_PRESETS = {
    tiny: '70x32#',
    small: '175x131#',
    medium: '207x137#',
    large: '355x235#'
  }
  delegate :thumb, to: :attachment
  dragonfly_accessor :attachment
  has_many :photo_album_photos
  has_many :photo_albums, through: :photo_album_photos
  belongs_to :uploader, class_name: 'User'

  def cropped_photo
    thumb("#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}")
  end

  def owned_by?(user)
    user == uploader
  end

  GALLERY_PHOTO_PRESETS.each do |name, size|
    define_method(name) do
      thumb(size).url
    end
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
