class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :attachment_uid
      t.string :source
      t.string :source_id
      t.integer :duration
      t.string :title
      t.datetime :published_at
      t.boolean :is_active

      change_references(t)

      t.timestamps
    end
  end

  def change_references(t)
    t.references :uploader
    t.foreign_key :users, column: :uploader_id

    t.references :release
    t.foreign_key :releases
  end
end