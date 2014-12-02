class Profile
  class Photo < ::Photo
    has_attached_file :attachment, styles: { small: '200x150', large: '400x300' }
    validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/
  end
end
