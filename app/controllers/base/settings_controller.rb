module Base
  class SettingsController < Base::BaseController
    def edit
      current_user.build_user_contacts if current_user.user_contacts.nil?
    end

    def update
      if current_user.valid_password?(password_params[:current_password])
        current_user.update(password_params.except(:current_password))
        sign_in(current_user, :bypass => true)
      end
      current_user.update(user_params)
      redirect_to edit_base_profile_settings_path(@profile)
    end

    def verify_authorized
      authorize :base, :access?
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   user_contacts_attributes: [:first_phone, :second_phone, :fax],
                                   email_notification_ids: [])
    end

    def password_params
      params.require(:passwords).permit(:current_password, :password, :password_confirmation)
    end
  end
end
