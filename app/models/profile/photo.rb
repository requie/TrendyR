class Profile
  class Photo < ::Photo
    def presets
      {
        cropped: "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}",
        homepage: '160x200#'
      }
    end
  end
end
