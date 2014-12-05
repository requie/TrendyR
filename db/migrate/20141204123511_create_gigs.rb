class CreateGigs < ActiveRecord::Migration
  def change
    create_table :gigs do |t|
      t.string :title
      t.decimal :price
      t.text :overview_text
      t.text :opportunity_text
      t.text :band_text
      t.text :gig_text
      t.text :terms_text
      t.datetime :started_at
      t.datetime :finished_at
      t.boolean :is_active, default: true

      change_references(t)

      t.timestamps
    end
  end

  def change_references(t)
    t.references :owner_profile
    t.foreign_key :profiles, column: :owner_profile_id

    t.references :location
    t.foreign_key :locations

    t.references :photo
    t.foreign_key :photos
  end
end
