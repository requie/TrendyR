class BookingDecorator < ApplicationDecorator
  delegate_all
  decorates_association :gig

  def status_label
    case model.status
    when 'confirmed' then 'Applied'
    when 'rejected' then 'Canceled'
    else 'Pending'
    end
  end

  def period
    [
      model.started_at.to_s(:short_date),
      model.finished_at.to_s(:short_date)
    ].join(' - ')
  end
end
