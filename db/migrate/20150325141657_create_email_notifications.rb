class CreateEmailNotifications < ActiveRecord::Migration
  def change
    create_table :email_notifications do |t|
      t.string :title
      t.string :name
      t.boolean :is_active, default: true

      change_references(t)

      t.timestamps
    end
  end

  def change_references(t)
    t.references :role
  end
end
