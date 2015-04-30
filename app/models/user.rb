class User < ActiveRecord::Base
  MAX_LENGTH = 100
  NAME_FORMAT = /\A[aA-zZаА-яЯЁё\-\. ]+\z/

  # :lockable, :timeoutable, :rememberable, :trackable
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: [:twitter, :facebook, :google_oauth2]
  acts_as_messageable

  has_one :profile
  has_one :identity
  has_one :user_contacts

  has_many :role_user
  has_many :roles, through: :role_user
  has_many :photos, foreign_key: :uploader_id
  has_many :email_notification_users
  has_many :email_notifications, through: :email_notification_users

  validates :first_name, :last_name, length: { maximum: MAX_LENGTH }, format: { with: NAME_FORMAT }, allow_blank: true
  validates :roles, presence: true

  accepts_nested_attributes_for :identity, :user_contacts, :email_notifications

  delegate :entity, to: :profile

  # as we now have only one roles for user, get the first one
  def role
    roles.first
  end

  def role?(role_name_sym)
    roles.pluck(:name).include?(role_name_sym.to_s)
  end

  def roles?(role_name_array)
    user_roles = roles.pluck(:name).to_set
    user_roles.subset? role_name_array.to_set
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

  def username
    "#{first_name} #{last_name}"
  end
end
