class RenameArtistGigToBooking < ActiveRecord::Migration
  def change
    rename_table('artists_gigs', 'bookings')
  end
end
