module SongHelper
  SONG_DURATION = '%M:%S'
  PUBLISHED_AT_FORMAT = '%B %d, %Y'

  def seconds_to_time(seconds)
    Time.at(seconds).utc.strftime(SONG_DURATION)
  end

  def date_with_format(date)
    date.strftime(PUBLISHED_AT_FORMAT)
  end
end
