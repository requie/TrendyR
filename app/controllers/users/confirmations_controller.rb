module Users
  class ConfirmationsController < Devise::ConfirmationsController
    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      yield resource if block_given?
      if is_flashing_format?
        message = resource.errors.empty? ? :confirmed : :already_confirmed
        set_flash_message(:notice, message)
      end
      respond_with_navigational(resource) do
        redirect_to(after_confirmation_path_for(resource_name, resource))
      end
    end
  end
end
