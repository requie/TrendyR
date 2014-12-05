class User < ActiveRecord::Base
  MAX_LENGTH = 100
  FORMAT = /\A[aA-zZаА-яЯЁё\-\. ]+\z/

  # :lockable, :timeoutable, :rememberable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :confirmable

  has_one :profile
  has_many :role_users
  has_many :roles, through: :role_users

  validates :first_name, :last_name, presence: true, length: { maximum: MAX_LENGTH }, format: { with: FORMAT }
  validates :roles, presence: true

  delegate :entity, to: :profile

  # used as an example, must change to use a real role from a relation
  def role
    'artist'
  end
end
