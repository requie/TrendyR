class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :title
      t.text :description_text
      t.datetime :earned_at
      t.boolean :is_active, default: true

      change_references(t)

      t.timestamps
    end
  end

  def change_references(t)
    t.references :owner_profile
    t.foreign_key :profiles, column: :owner_profile_id

    t.references :photo
    t.foreign_key :photos
  end
end
