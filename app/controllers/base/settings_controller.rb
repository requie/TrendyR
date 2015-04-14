module Base
  class SettingsController < Base::BaseController
    CONTACTS_ATTRIBUTES = %i(first_phone second_phone fax)
    USER_ATTRIBUTES = %i(first_name last_name email)
    PASSWORD_ATTRIBUTES = %i(current_password password password_confirmation)

    def edit
      current_user.build_user_contacts if current_user.user_contacts.nil?
    end

    def update
      current_user.update(user_params)
      password_changed = passwords_present? && current_user.update_with_password(password_params)
      sign_in(current_user, bypass: true) if password_changed
      set_flash_messages
      redirect_to edit_base_profile_settings_path(@profile)
    end

    def verify_authorized
      authorize :base, :access?
    end

    private

    def user_params
      params.require(:user).permit(
        *USER_ATTRIBUTES,
        email_notification_ids: [],
        user_contacts_attributes: CONTACTS_ATTRIBUTES
      )
    end

    def password_params
      params.require(:passwords).permit(*PASSWORD_ATTRIBUTES)
    end

    def passwords_present?
      password_params.values.join.present?
    end

    def set_flash_messages
      if current_user.errors.blank?
        flash[:notice] = t('settings.success')
      else
        flash[:alert] = current_user.errors.full_messages
      end
    end
  end
end
