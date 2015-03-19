class CreateReleasesSongs < ActiveRecord::Migration
  def change
    create_join_table :releases, :songs do |t|
      t.foreign_key :releases, dependent: :delete
      t.foreign_key :songs, dependent: :delete
    end
  end
end
