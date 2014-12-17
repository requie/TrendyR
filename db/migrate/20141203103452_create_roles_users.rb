class CreateRolesUsers < ActiveRecord::Migration
  def change
    create_join_table :roles, :users do |t|
      t.foreign_key :users, dependent: :delete
      t.foreign_key :roles, dependent: :delete
    end
  end
end
