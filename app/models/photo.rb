class Photo < ActiveRecord::Base
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

  def tiny
    thumb('70x32#').url
  end

  def small
    thumb('175x131#').url
  end

  def medium
    thumb('207x137#').url
  end

  def large
    thumb('355x235#').url
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
