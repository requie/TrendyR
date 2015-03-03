module ProfileHelper
  DATE_FORMAT = '%b %d, %Y'

  def period(object)
    dates = []
    dates << object.started_at.strftime(DATE_FORMAT) if object.started_at.present?
    dates << object.finished_at.strftime(DATE_FORMAT) if  object.finished_at.present?
    dates.join(' - ')
  end

  def event_or_gig_photo(object, image_path)
    days = days_before_the_date(object.started_at)
    if days > days_in_this_month
      wrap_photo(days_to_months(days), image_path, :month, :mth)
    elsif days > 0
      wrap_photo(days, image_path, :days)
    elsif continuing_now?(object)
      wrap_photo(nil, image_path, :now)
    end
  end

  private

  def wrap_photo(length, image_path, class_sym, caption_sym = nil)
    caption_sym = class_sym if caption_sym.nil?
    content_tag :div, class: "promo-logo-#{class_sym}" do
      link_to '' do
        image_tag(image_path, class: 'mobile-center') +
          content_tag(:div, "#{length  if length.present?} #{caption_sym}", class: "logo-#{class_sym}")
      end
    end
  end

  def days_in_this_month
    Time.now.end_of_month.day
  end

  def days_to_months(days)
    days / days_in_this_month
  end

  def days_before_the_date(date)
    ((date - Time.zone.now) / 1.day).round
  end

  def continuing_now?(object)
    Date.today.between?(object.started_at.to_date, object.finished_at.to_date)
  end
end
