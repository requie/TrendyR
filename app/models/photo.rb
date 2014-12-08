class Photo < ActiveRecord::Base
  delegate :thumb, to: :attachment
  dragonfly_accessor :attachment

  # redifine the method in child classes to contain presets
  # {
  #   tiny: '100x100#',
  #   big: '500x500'
  # }
  def presets
    {}
  end
end
