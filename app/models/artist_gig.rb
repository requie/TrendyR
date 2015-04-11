class ArtistGig < ActiveRecord::Base
  AVAILABLE_STATUSES = %w(confirmed rejected started pending)
  self.table_name = 'artists_gigs'

  belongs_to :artist
  belongs_to :gig

  validates :status, inclusion: AVAILABLE_STATUSES
  scope :with_status, ->(status) { where(status: status) }

  delegate :profile, to: :artist
end
