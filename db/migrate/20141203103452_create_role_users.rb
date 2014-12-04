class CreateRoleUsers < ActiveRecord::Migration
  def change
    create_table :role_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :role

      t.timestamps
    end
  end
end
