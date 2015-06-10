{
  date: '%B %d, %Y',
  short_date: '%b %d, %Y',
  month: '%b, %Y',
  dotted: '%d.%m.%Y',
  full_dotted: '%d.%m.%Y / %H:%M',
  datepicker: '%d/%m/%Y'
}.each do |format, value|
  Time::DATE_FORMATS[format] = value
  Date::DATE_FORMATS[format] = value
end
