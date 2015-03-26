class EmailNotificationUser < ActiveRecord::Base
  self.table_name = 'email_notifications_users'

  belongs_to :email_notification
  belongs_to :user
end
