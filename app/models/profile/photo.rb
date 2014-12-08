class Profile
  class Photo < ::Photo
    def presets
      {
        homepage: '50x50#'
      }
    end
  end
end
