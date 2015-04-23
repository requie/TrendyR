class Release
  class Photo < ::Photo
    def presets
      {
        tiny: '40x40#',
        small: '100x100#',
        medium: '200x127#'
      }
    end
  end
end
