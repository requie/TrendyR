class Booking < ActiveRecord::Base
  AVAILABLE_STATUSES = %w(confirmed rejected pending)

  paginates_per 15

  belongs_to :artist
  belongs_to :gig
  delegate :profile, to: :artist

  scope :with_status, ->(status) { where(status: status) }

  AVAILABLE_STATUSES.each do |status|
    scope status.to_sym, -> { where(status: status) }
    define_method "#{status}?" do
      self.status == status
    end
  end

  validates :started_at, :finished_at, :gig_id, :artist_id, presence: true
  validates :status, inclusion: AVAILABLE_STATUSES
  validate :booking_period, if: :allow_period_validation

  private

  def allow_period_validation
    started_at.present? && finished_at.present?
  end

  def booking_period
    dates_conflict || period_out_of_date || periods_conflict
  end

  def dates_conflict
    return if started_at < finished_at
    errors.add(:started_at, 'dates conflict')
    errors.add(:finished_at, 'dates conflict')
  end

  def period_out_of_date
    now = DateTime.current.at_beginning_of_day
    return if started_at > now && finished_at > now
    errors.add(:started_at, 'dates conflict')
    errors.add(:finished_at, 'dates conflict')
  end

  def periods_conflict
    return if artist_id.blank?
    booking = artist.bookings.confirmed.where(
      '(started_at, finished_at) OVERLAPS (:started, :finished)',
      started: started_at, finished: finished_at
    ).first
    return if booking.blank?
    errors.add(:started_at, 'dates conflict')
    errors.add(:finished_at, 'dates conflict')
  end
end
