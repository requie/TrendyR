class Photo < ActiveRecord::Base
  delegate :thumb, :thumb!, :url, to: :attachment
  dragonfly_accessor :attachment
  has_many :photo_album_photos
  has_many :photo_albums, through: :photo_album_photos
  belongs_to :uploader, class_name: 'User'

  def cropped
    thumb("#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}").url
  end

  def owned_by?(user)
    user == uploader
  end

  def with_preset(preset_name)
    thumb(presets[preset_name]).url
  end

  def with_presets(preset_syms)
    resized_photo = self
    preset_syms.each do |preset|
      resized_photo = resized_photo.thumb(presets[preset])
    end
    resized_photo.url
  end

  # redifine the method in child classes to contain presets
  # {
  #   tiny: '100x100#',
  #   big: '500x500'
  # }
  def presets
    {
      cropped: "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}",
      avatar: '165x150#',
      wallpaper: '1170x240',
      event_photo: '750x180#'
    }
  end
end
