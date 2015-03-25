class PhotoAlbum
  class Photo < ::Photo
    def presets
      {
        tiny: '70x32#',
        small: '175x131#',
        medium: '207x137#',
        large: '355x235#'
      }
    end
  end
end
