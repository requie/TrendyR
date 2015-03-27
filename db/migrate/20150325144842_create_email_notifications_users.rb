class CreateEmailNotificationsUsers < ActiveRecord::Migration
  def change
    create_join_table :email_notifications, :users do |t|
      t.foreign_key :email_notifications, dependent: :delete
      t.foreign_key :users, dependent: :delete
    end
  end
end
