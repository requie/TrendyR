class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception
  before_action :set_inbox_messages, if: -> { user_signed_in? && !request.xhr? }
  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized, unless: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :role_ids])
  end

  def set_inbox_messages
    @inbox_messages = current_user.unread_messages
    @inbox_notifications = current_user.mailbox.notifications(read: false).not_trashed
  end
end
