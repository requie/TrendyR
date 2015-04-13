class CreateArtistGigs < ActiveRecord::Migration
  def change
    create_table :artists_gigs do |t|
      t.string :status, default: 'pending'
      t.references :artist
      t.references :gig
      t.foreign_key :artists, dependent: :delete
      t.foreign_key :gigs, dependent: :delete
    end
  end
end
