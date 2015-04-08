class CreateArtistGigs < ActiveRecord::Migration
  def change
    create_table :artists_gigs do |t|
      t.string :status, default: 'pending'
      t.references :artist, dependent: :delete
      t.references :gig, dependent: :delete
    end
  end
end
