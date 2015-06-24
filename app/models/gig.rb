class Gig < ActiveRecord::Base
  include Ownable
  include Locationable

  SAFE_SCOPES = %w(started pending past)

  acts_as_commentable

  has_many :faqs, -> { order(:created_at) }, class_name: 'GigFaq'
  has_many :bookings, -> { where(source: 'request') }, dependent: :destroy
  has_many :pending_bookings, -> { where(source: 'request', status: 'pending') }, dependent: :destroy, class_name: 'Booking'
  has_many :artists, -> { where('bookings.status' => 'confirmed') }, through: :bookings
  belongs_to :photo, class_name: 'Gig::Photo'
  belongs_to :event, class_name: 'Event'

  has_many :category_categorizable, as: :categorizable
  has_many :category, through: :category_categorizable

  accepts_nested_attributes_for :faqs, reject_if: ->(faq) { faq[:question].blank? || faq[:answer].blank? }

  scope :upcoming, -> { where('finished_at > ?', Date.today).order('started_at') }
  scope :started, -> { where('started_at < :date AND finished_at > :date', date: Date.today) }
  scope :pending, -> { where('started_at > ?', Date.today) }
  scope :past, -> { where('finished_at < ?', Date.today) }
  scope :at_date, ->(date) { where('started_at < ? AND finished_at > ?', date) }


  class << self
    def with_status(status)
      if SAFE_SCOPES.include? status
        send(status)
      else
        all
      end
    end

    def batch_update(ids, values)
      ActiveRecord::Base.transaction do
        Gig.update(ids, values)
      end
    end
  end
end
