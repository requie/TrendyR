class AddIsFeaturedToGigsAndArtists < ActiveRecord::Migration
  def change
    add_column :gigs, :is_featured, :boolean, default: false
    add_column :artists, :is_featured, :boolean, default: false
  end
end
