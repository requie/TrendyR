class Gig < ActiveRecord::Base
  include Ownable
  include Locationable
  SAFE_SCOPES = %w(started pending past)
  paginates_per 12

  has_many :faqs, -> { order(:created_at) }, class_name: 'GigFaq'
  accepts_nested_attributes_for :faqs, reject_if: ->(faq) { faq[:question].blank? || faq[:answer].blank? }
  has_many :artist_gigs, dependent: :destroy
  has_many :artists, through: :artist_gigs
  belongs_to :photo, class_name: 'Gig::Photo'

  scope :started, -> { where('started_at < :today and finished_at > :today',  today: Date.today) }
  scope :pending, -> { where('started_at > ?', Date.today) }
  scope :past, -> { where('finished_at < ?', Date.today) }

  def self.with_status(status)
    if SAFE_SCOPES.include? status
      send(status)
    else
      all
    end
  end

  def self.batch_update(ids, values)
    ActiveRecord::Base.transaction do
      Gig.update(ids, values)
    end
  end
end
