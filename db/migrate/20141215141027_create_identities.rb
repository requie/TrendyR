class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :provider
      t.string :uid
      t.string :token
      t.string :secret
      t.text :data
      t.datetime :token_expires_at
      t.boolean :is_active, default: true

      t.references :user
      t.foreign_key :users, dependent: :delete

      t.timestamps
    end
  end
end
