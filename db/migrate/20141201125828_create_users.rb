class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ''
      t.string :first_name
      t.string :last_name
      t.boolean :is_active, default: true

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
