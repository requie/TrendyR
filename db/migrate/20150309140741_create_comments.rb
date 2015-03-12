class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.boolean :is_active

      change_references(t)

      t.timestamps
    end
  end

  def change_references(t)
    t.references :author
    t.foreign_key :users, column: :author_id
  end
end
