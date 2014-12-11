class Role < ActiveRecord::Base
  PUBLIC = %w(artist label)
  # PUBLIC = %w(artist label manager producer venue)
  PRIVATE = %w(admin)
  ALL = PUBLIC + PRIVATE

  has_many :role_user
  has_many :users, through: :role_user

  scope :is_public, -> { where(is_public: true) }

  # get role object by its name
  def self.instance(role_name)
    role_name = role_name.to_s unless role_name.is_a?(String)
    find_by_name(role_name)
  end

  # check if role is public by passing it's name
  def self.public?(role_name)
    role_name = role_name.to_s unless role_name.is_a?(String)
    PUBLIC.include?(role_name)
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
