class Role < ActiveRecord::Base
  PUBLIC = %w(artist label manager producer venue)
  PRIVATE = %w(admin)
  ALL = PUBLIC + PRIVATE

  has_many :role_user
  has_many :users, through: :role_user

  scope :is_public, -> { where(is_public: true) }

  # get role object by its name
  def self.instance(role_name)
    find_by(name: role_name.to_s)
  end

  # check if role is public by passing it's name
  def self.public?(role_name)
    PUBLIC.include?(role_name.to_s)
  end

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
