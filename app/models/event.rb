class Event < ActiveRecord::Base
  include Ownable
  include Locationable

  SAFE_SCOPES = %w(started pending past)

  paginates_per 10

  scope :upcoming, -> { where('finished_at > ?', Date.today).order('started_at') }
  scope :started, -> { where('started_at < :today and finished_at > :today',  today: Date.today) }
  scope :pending, -> { where('started_at > ?', Date.today) }
  scope :past, -> { where('finished_at < ?', Date.today) }
  scope :at_date, ->(date) { where('started_at < :date and finished_at > :date',  date: date) }
  scope :since_date, ->(date) { where('started_at >= :date',  date: date) }

  belongs_to :photo, class_name: 'Event::Photo'

  validates :title, :description_text, :started_at, :finished_at, :photo, presence: true

  def self.with_status(status)
    if SAFE_SCOPES.include? status
      send(status)
    else
      all
    end
  end
end
