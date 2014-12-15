module Users
  class PasswordsController < Devise::PasswordsController
    def update
      self.resource = resource_class.reset_password_by_token(resource_params)
      yield resource if block_given?

      if resource.errors.empty?
        after_reset_password
      else
        respond_with resource
      end
    end

    def password_recover_instructions
      flash[:notice] = nil
    end

    protected

    def after_resetting_password_path_for(resource_name)
      new_session_path(resource_name)
    end

    def after_sending_reset_password_instructions_path_for(_resource_name)
      recover_path
    end

    def after_reset_password
      resource.unlock_access! if unlockable?(resource)
      if is_flashing_format?
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message(:notice, flash_message)
      end
      respond_with resource, location: after_resetting_password_path_for(resource_name)
    end
  end
end
