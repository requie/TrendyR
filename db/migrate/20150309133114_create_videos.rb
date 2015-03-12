class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :attachment_uid
      t.string :source
      t.string :source_id
      t.integer :duration
      t.string :title
      t.text :description_text
      t.boolean :is_active

      t.references :uploader
      t.foreign_key :users, column: :uploader_id

      t.timestamps
    end
  end
end
