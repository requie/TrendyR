class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.boolean :is_active, default: true

      t.references :profile
      t.foreign_key :profiles, dependent: :delete

      t.timestamps
    end
  end
end
