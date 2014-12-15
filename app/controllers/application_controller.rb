class ApplicationController < ActionController::Base
  # Include Pundit
  include Pundit
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  # check if Pundit is used for developing purposes
  # https://github.com/elabs/pundit#ensuring-policies-are-used
  after_action :verify_authorized, unless: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name, :role_ids]
  end
end