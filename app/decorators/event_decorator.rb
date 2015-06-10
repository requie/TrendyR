class EventDecorator < ApplicationDecorator
  delegate_all

  def period
    [
      model.started_at.to_s(:short_date),
      model.finished_at.to_s(:short_date)
    ].join(' - ')
  end
end
