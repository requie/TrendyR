class UseDragonflyForPhotos < ActiveRecord::Migration
  def up
    change_table :photos do |t|
      t.remove :attachment_file_name, :attachment_content_type, :attachment_file_size, :attachment_updated_at
      t.string :attachment_uid
    end
  end

  def down
    change_table :photos do |t|
      t.string :attachment_file_name
      t.string :attachment_content_type
      t.integer :attachment_file_size
      t.datetime :attachment_updated_at
      t.remove :attachment_uid
    end
  end
end
