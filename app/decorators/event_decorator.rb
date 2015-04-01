class EventDecorator < ApplicationDecorator
  DATE_FORMAT = '%b %d, %Y'
  delegate_all

  def status
    set_distances

    if @to_finish < 0
      :past
    elsif @to_start >= 0
      :started
    else
      :pending
    end
  end

  def period
    dates = []
    dates << model.started_at.strftime(DATE_FORMAT)
    dates << model.finished_at.strftime(DATE_FORMAT)
    dates.join(' - ')
  end

  private

  def set_distances
    @to_start = h.distance_of_time_in(from: model.started_at)
    @to_finish = h.distance_of_time_in(to: model.finished_at)
  end
end
