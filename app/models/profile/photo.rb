class Profile
  class Photo < ::Photo
    has_one :profile

    %w(artist label manager producer venue).each do |type|
      update_index("search##{type}") { profile.entity if profile && profile.entity.class.to_s.downcase == type }
    end

    def presets
      {
        mini_autocomplete: '40x40#',
        big_autocomplete: '200x200#',
        mini: '26x26',
        cropped: "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}",
        homepage: '160x200#',
        private_homepage: '165x150#'
      }
    end
  end
end
