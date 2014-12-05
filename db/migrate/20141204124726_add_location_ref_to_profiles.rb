class AddLocationRefToProfiles < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.references :location
      t.foreign_key :locations
    end
  end
end
