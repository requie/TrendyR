class EventDecorator < ApplicationDecorator
  DATE_FORMAT = '%b %d, %Y'

  def period
    "#{object.started_at.strftime(DATE_FORMAT) if object.started_at} \
        - #{object.finished_at.strftime(DATE_FORMAT) if  object.finished_at}"
  end
end
