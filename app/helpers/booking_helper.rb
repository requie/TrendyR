module BookingHelper
  def calendar_navigation(date)
    prev_date = date.prev_month.to_date
    next_month = date.next_month.to_date
    [
      '<p>',
      link_to('<i class="icon-left"></i>'.html_safe, public_profile_bookings_path(date: prev_date)),
      content_tag(:span),
      link_to('<i class="icon-right"></i>'.html_safe, public_profile_bookings_path(date: next_month)),
      '</p>'
    ].join.html_safe
  end
end
