module ProfileHelper
  def location_address(model)
    model.location ? model.location.address : ''
  end

  def photo_promo_logo(model)
    to_start = distance_of_time_in(:days, to: model.started_at)
    to_finish = distance_of_time_in(:hours, to: model.finished_at)

    if to_start > 0
      if to_start > days_in_this_month
        {
          distance: distance_of_time_in(:months, to: model.started_at),
          label: 'MTH',
          class: 'month'
        }
      else
        {
          distance: to_start,
          label: 'DAYS',
          class: 'days'
        }
      end
    elsif to_finish >= 0
      {
        label: 'NOW',
        class: 'now'
      }
    end
  end

  private

  def days_in_this_month
    Time.now.end_of_month.day
  end
end
