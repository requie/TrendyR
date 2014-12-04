class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :encrypted_password, null: false, default: ''
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
    end

    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token, unique: true
  end

  def self.down
    fail ActiveRecord::IrreversibleMigration
  end
end
