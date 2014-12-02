class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.attachment :attachment
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
