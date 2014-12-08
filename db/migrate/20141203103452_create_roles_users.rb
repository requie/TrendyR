class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_join_table :roles, :users do |t|
      t.foreign_key :users
      t.foreign_key :roles
    end
  end
end
