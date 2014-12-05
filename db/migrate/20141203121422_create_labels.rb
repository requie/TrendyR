class CreateLabels < ActiveRecord::Migration
  def change
    create_table :labels do |t|
      t.boolean :is_active, default: true

      t.references :profile
      t.foreign_key :profiles

      t.timestamps
    end
  end
end
