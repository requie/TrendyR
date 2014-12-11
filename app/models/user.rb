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

  # as we now have only one roles for user, get the first one
  def role
    roles.first
  end

  def role?(role_name_sym)
    roles.pluck(:name).include?(role_name_sym.to_s)
  end

  # user's entity class like Artist or Label
  # use carefully, because it depends on declared classes
  def entity_class
    "#{role.name.capitalize}".constantize
  end

  # build Profile and relate to current user
  # also build entity according to selected role and connect it to profile
  # make sure you call this method when creating users manually
  def after_confirmation
    entity_class.create(profile: build_profile)
    save!
  end
end
