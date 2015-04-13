class Artist < ActiveRecord::Base
  include Rolable

  has_many :artist_gigs, dependent: :destroy
  has_many :gigs, through: :artist_gigs

  def self.batch_update(ids, values)
    ActiveRecord::Base.transaction do
      Artist.update(ids, values)
    end
  end
end
