class Booking < ActiveRecord::Base
  AVAILABLE_STATUSES = %w(confirmed rejected pending)
  # request - if artist is booking
  # offer - if venue is booking
  SOURCE_TYPES = %w(request offer)

  paginates_per 15

  belongs_to :artist
  belongs_to :gig
  belongs_to :evemt
  belongs_to :user
  delegate :profile, to: :artist

  scope :with_status, ->(status) { where(status: status) }
  scope :active, -> { where(is_active: true) }

  AVAILABLE_STATUSES.each do |status|
    scope status.to_sym, -> { where(status: status) }
    define_method "#{status}?" do
      self.status == status
    end
  end

  validates :gig_id, :artist_id, presence: true
  validates :started_at, :finished_at, presence: true, if: -> { source && source == 'request' }
  validates :status, inclusion: AVAILABLE_STATUSES
  validates :source, inclusion: SOURCE_TYPES
  validate :booking_period, if: :allow_period_validation

  def send_booking_notify(sender, recipient, status, send_mail)
    case status
      when :created
        subject = "Booking request from #{self.user.username}"
        body = "Booking request from #{self.user.username}. Gig - #{self.gig.title}"
      when :rejected
        subject = "Booking request to #{self.artist.user.username} has been canceled"
        body = "Booking request to #{self.artist.user.username} has been canceled"
      when :confirmed
        subject = "Booking request to #{self.artist.user.username} has been confirmed"
        body = "Booking request to #{self.artist.user.username} has been confirmed"
    end
    recipient.notify(subject, body, self, true, nil, send_mail)
    notification = recipient.mailbox.notifications.first
    notification.sender = sender
    notification.save
  end

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
