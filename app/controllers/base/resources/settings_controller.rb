module Base
  module Resources
    class SettingsController < Resources::BaseController
      USER_ATTRIBUTES = [
        :first_name, :last_name, :email, email_notification_ids: [],
                                         user_contacts_attributes: [:first_phone, :second_phone, :fax]
      ]
      PASSWORD_ATTRIBUTES = %i(current_password password password_confirmation)

      def show
        current_user.build_user_contacts if current_user.user_contacts.nil?
      end

      def update
        current_user.update(user_params)
        if passwords_present? && current_user.update_with_password(password_params)
          sign_in(current_user, bypass: true)
        end
        set_flash_messages
        redirect_to settings_path
      end

      private

      def user_params
        params.require(:user).permit(USER_ATTRIBUTES)
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
end
