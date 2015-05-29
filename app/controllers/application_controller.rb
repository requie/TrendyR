class ApplicationController < ActionController::Base
  include Pundit

  protect_from_forgery with: :exception

  before_action :authenticate_user!, unless: :devise_controller?
  before_action :set_profile, if: -> { user_signed_in? }
  before_action :set_inbox_messages, if: -> { user_signed_in? && !request.xhr? }
  before_action :configure_permitted_parameters, if: :devise_controller?

  after_action :verify_authorized, unless: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :role_ids]
  end

  def set_profile
    @profile = current_user.profile
  end

  def set_inbox_messages
    @inbox_messages = current_user.unread_messages
  end
end
