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
      model.started_at.to_date.to_formatted_s(:short),
      model.finished_at.to_date.to_formatted_s(:short)
    ].join(' - ')
  end
end
