module Base
  module Resources
    class NotificationsController < Resources::BaseController
      skip_before_action :set_location_for_js
      before_action :set_mailbox
      before_action :set_recipient, only: [:new, :create]
      before_action :set_notification, only: [:show, :destroy]

      def index
        @notifications = @mailbox.notifications.not_trashed
      end

      def show
        @notification.mark_as_read(current_user) if @notification.is_unread?(current_user)
        redirect_to action: :index
      end

      def destroy
        @notification.move_to_trash(current_user)
        redirect_to action: :index
      end

      private

      def set_mailbox
        @mailbox = current_user.mailbox
      end

      def set_recipient
        @recipient = User.find(params[:recipient_id])
      end

      def set_notification
        @notification = @mailbox.notifications.find(params[:id])
      end
    end
  end
end
