class Event < ActiveRecord::Base
  SAFE_SCOPES = %w(started pending past)

  include Ownable
  include Locationable
  include Indexable

  paginates_per 10

  acts_as_commentable

  has_many :gigs, dependent: :nullify
  has_many :artists, through: :gigs
  belongs_to :photo, class_name: 'Event::Photo'
  has_many :category_categorizable, as: :categorizable
  has_many :category, through: :category_categorizable

  scope :upcoming, -> { where('finished_at > ?', Date.today).order(:started_at) }
  scope :started, -> { where('started_at < :today and finished_at > :today', today: Date.today) }
  scope :pending, -> { where('started_at > ?', Date.today) }
  scope :past, -> { where('finished_at < ?', Date.today) }
  scope :at_date, ->(date) { where('started_at < :date and finished_at > :date', date: date) }
  scope :since_date, ->(date) { where('started_at >= :date', date: date) }

  validates :title, :description_text, :started_at, :finished_at, :photo, presence: true

  def self.with_status(status)
    if SAFE_SCOPES.include? status
      send(status)
    else
      all
    end
  end

  def past?
    finished_at.to_date < Date.today
  end
end
