class Profile
  class Wallpaper < ::Photo
    has_attached_file :attachment, styles: { tiny: '20x15', big: '1400x1300' }
    validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/
  end
end
