class Profile
  class Photo < ::Photo
    def presets
      {
        mini: '26x26',
        cropped: "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}",
        homepage: '160x200#',
        private_hompage: '165x150#'
      }
    end
  end
end
