class User < ActiveRecord::Base
  MAX_LENGTH = 100
  FORMAT = /\A[aA-zZаА-яЯЁё\-\. ]+\z/

  # :lockable, :timeoutable, :rememberable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :confirmable

  has_one :profile
  has_many :role_user
  has_many :roles, through: :role_user

  validates :first_name, :last_name, presence: true, length: { maximum: MAX_LENGTH }, format: { with: FORMAT }
  validates :roles, presence: true

  delegate :entity, to: :profile

  # name of a user role like "artist" or "label"
  def role_name
    roles.first.name
  end

  # user's entity class like Artist or Label
  def entity_class
    "#{role_name.capitalize}".constantize
  end

  # build Profile and relate to current user
  # also build entity according to selected role and connect it to profile
  def after_confirmation
    entity_class.create(profile: build_profile)
    save!
  end
end
