class AddStartTimeToGigs < ActiveRecord::Migration
  def change
    add_column :gigs, :start_time, :time
    rename_column :gigs, :gig_text, :venue_details_text
  end
end
