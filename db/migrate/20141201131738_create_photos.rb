class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at
      t.integer :crop_x
      t.integer :crop_y
      t.integer :crop_w
      t.integer :crop_h

      t.references :uploader
      t.foreign_key :users, column: :uploader_id

      t.timestamps
    end
  end
end
