class Event
  class Photo < ::Photo
    def presets
      {
        standard: '200x200',
        medium: '200x127#',
        cropped: "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}",
        mini_autocomplete: '40x40#',
        big_autocomplete: '260x200#',
      }
    end
  end
end
