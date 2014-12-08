class Role < ActiveRecord::Base
  PUBLIC = %w(artist label manager producer venue)
  PRIVATE = %w(superadmin)
  ALL = PUBLIC + PRIVATE

  has_many :role_user
  has_many :users, through: :role_user

  scope :is_public, -> { where(is_public: true) }

  # UI titles for the public roles
  def self.public_titles
    {
      artist: 'Artist / DJ',
      label: 'Label',
      manager: 'Manager',
      producer: 'Producer',
      venue: 'Venue'
    }
  end

  # method to create labels for a dropdown on the sign up form
  def public_labels
    Role.public_titles[name.to_sym]
  end
end
