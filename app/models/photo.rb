class Photo < ActiveRecord::Base
  delegate :thumb, to: :attachment
  dragonfly_accessor :attachment

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
