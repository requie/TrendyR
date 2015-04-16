class RemoveUsersForeignKeyFromLocations < ActiveRecord::Migration
  def self.up
    remove_foreign_key(:locations, :creator)
  end

  def self.down
    add_foreign_key(:locations, :users, column: :creator_id)
  end
end
