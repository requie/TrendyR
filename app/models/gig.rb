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

  scope :upcoming, -> { where('finished_at > ?', Date.today).order('started_at') }

  scope :started, -> { where('started_at < :today and finished_at > :today',  today: Date.today) }
  scope :pending, -> { where('started_at > ?', Date.today) }
  scope :past, -> { where('finished_at < ?', Date.today) }

  scope :at_date, ->(date) { where('started_at < :today and finished_at > :today',  today: date) }

  def self.with_status(status)
    if SAFE_SCOPES.include? status
      send(status)
    else
      all
    end
  end

  def self.filtered(filters)
    gigs = all
    source_place_id = filters[:source_place_id]
    gigs = gigs.joins(:location).where(locations: { source_place_id: source_place_id }) if source_place_id.present?
    gigs = gigs.at_date(filters[:date].to_date) if filters[:date].present?
    gigs
  end

  def self.batch_update(ids, values)
    ActiveRecord::Base.transaction do
      Gig.update(ids, values)
    end
  end
end
