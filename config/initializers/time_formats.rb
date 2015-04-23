{
  date: '%B %d, %Y',
  short_date: '%b %d, %Y',
  month: '%b, %Y'
}.each do |format, value|
  Time::DATE_FORMATS[format] = value
  Date::DATE_FORMATS[format] = value
end
