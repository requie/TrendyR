class EmailNotification < ActiveRecord::Base
  has_one :role

  has_many :email_notification_users
  has_many :users, through: :email_notification_users
end
