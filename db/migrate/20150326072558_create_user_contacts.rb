class CreateUserContacts < ActiveRecord::Migration
  def change
    create_table :user_contacts do |t|
      t.string :first_phone
      t.string :second_phone
      t.string :fax

      change_references(t)
    end
  end

  def change_references(t)
    t.references :user
  end
end
