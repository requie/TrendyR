class Artist < ActiveRecord::Base
  include Rolable
  include Indexable

  has_many :bookings, -> { where(source: 'offer').order(created_at: :desc) }
  has_many :gigs, through: :bookings
  has_many :releases, -> { order(created_at: :desc) }
  has_many :songs, through: :releases do
    def last_song
      order(created_at: :desc).first
    end
  end

  def self.batch_update(ids, values)
    ActiveRecord::Base.transaction do
      Artist.update(ids, values)
    end
  end

  def gigs_calendar(date)
    start_date = date.beginning_of_month
    end_date = date.end_of_month
    result = gigs_for_period(start_date, end_date)
    result.each_with_object((start_date..end_date).to_a) do |booking, calendar|
      calendar[booking.day - 1] = [calendar[booking.day - 1], booking.gig]
    end
  end

  def gigs_for_period(start_date, end_date)
    select_query = 'bookings.*, EXTRACT(DAY FROM t)::integer as day'
    join_query = %{
      JOIN generate_series('#{start_date}', '#{end_date}', '1 day'::interval) t
      ON t BETWEEN bookings.started_at AND bookings.finished_at
    }
    bookings.confirmed.select(select_query).joins(join_query).order('day ASC')
  end

  def last_release
    releases.first
  end

  def upcoming_event
    Event.none.first
  end
end
