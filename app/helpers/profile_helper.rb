module ProfileHelper
  DATE_FORMAT = '%b %d, %Y'

  def period(object)
    "#{object.started_at.strftime(DATE_FORMAT) if object.started_at} " \
    "- #{object.finished_at.strftime(DATE_FORMAT) if  object.finished_at}"
  end

  def event_or_gig_photo(object, image_path)
    days = days_to_date(object.started_at)
    if days > days_left_in_this_month
      wrap_photo(days_to_months(days), image_path, :month, :mth)
    elsif days > 0
      wrap_photo(days, image_path, :days)
    elsif days == 0
      wrap_photo(days, image_path, :now)
    else
      wrap_photo(nil, image_path, :now)
    end
  end

  private

  def wrap_photo(length, image_path, class_sym, caption_sym = nil)
    caption_sym = class_sym if caption_sym.nil?
    content_tag :div, class: "promo-logo-#{class_sym}" do
      link_to '' do
        concat image_tag(image_path, class: 'mobile-center')
        concat content_tag(:div, "#{length if length.nonzero?} #{caption_sym}", class: "logo-#{class_sym}") if length.present?
      end
    end
  end

  def days_in_this_month
    Time.now.end_of_month.day
  end

  def days_to_months(days)
    days / (1.month / 1.day)
  end

  def days_left_in_this_month
    days_in_this_month - Time.now.day
  end

  def days_to_date(date)
    ((date - Time.zone.now) / 1.day).round
  end
end
