class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email, null: false, default: ''

      t.timestamps
    end

    add_index :subscriptions, :email, unique: true
  end
end