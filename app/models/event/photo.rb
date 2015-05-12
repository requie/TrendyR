class Event
  class Photo < ::Photo
    def presets
      {
        standard: '200x200',
        medium: '200x127#',
        cropped: "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
      }
    end
  end
end
