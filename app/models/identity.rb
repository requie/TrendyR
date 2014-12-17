class Identity < ActiveRecord::Base
  belongs_to :user
  validates :uid, :provider, presence: true
  validates :uid, uniqueness: { scope: :provider }

  def twitter?
    provider.downcase == 'twitter'
  end
end
