class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.integer :weight, default: 0
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
