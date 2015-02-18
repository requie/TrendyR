class CreateManagers < ActiveRecord::Migration
  def change
    create_table :managers do |t|
      t.boolean :is_active, default: true

      t.references :profile
      t.foreign_key :profiles, dependent: :delete

      t.timestamps
    end
  end
end
