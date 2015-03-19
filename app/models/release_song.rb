class ReleaseSong < ActiveRecord::Base
  self.table_name = 'releases_songs'

  belongs_to :release
  belongs_to :song
end
