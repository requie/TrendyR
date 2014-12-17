module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    PROVIDERS = [:twitter, :facebook, :google_oauth2]

    def self.provides_callback_for(provider)
      class_eval %{
        def #{provider}
          user_info = user_info_attributes(env["omniauth.auth"])
          unless authorize_by_identity(user_info[:identity_attributes], "#{provider}")
            user = User.find_by(email: user_info[:email])
            if user.present?
              set_flash_message(:alert, :used)
              redirect_to new_user_registration_url
            else
              session['omniauth'] = user_info
              @user = User.new(user_info)
              render :register
            end
          end
        end
      }
    end

    PROVIDERS.each do |provider|
      provides_callback_for provider
    end

    def create
      @user = build_user
      if @user.nil?
        redirect_to root_path
        return
      end
      unless @user.save
        render :register
        return
      end
      session['omniauth'] = nil
      @user.after_confirmation
      if @user.active_for_authentication?
        set_flash_message(:notice, :signed_up) if is_flashing_format?
        sign_in(@user)
        respond_with(@user, location: signed_in_root_path(@user))
      else
        set_flash_message(:notice, :"signed_up_but_#{resource.inactive_message}") if is_flashing_format?
        expire_data_after_sign_in!
        respond_with(@user, location: new_session_path(@user))
      end
    end

    protected

    def authorize_user(user, provider)
      set_flash_message(:notice, :success, kind: "#{provider}".capitalize) if is_navigational_format?
      sign_in_and_redirect(user, event: :authentication)
    end

    def authorize_by_identity(identity_info, provider)
      identity = Identity.find_by(identity_info)
      authorize_user(identity.user, "#{provider}") if identity.present?
    end

    def user_info_attributes(attributes)
      identity_attributes = attributes.slice(:uid, :provider)
      user_attributes = attributes['info'].slice(:email, :first_name, :last_name)
      attrs = user_attributes.merge(identity_attributes: identity_attributes)
      ActionController::Parameters.new(attrs).except(:name).permit!
    end

    def build_user
      user_attributes = session['omniauth']
      return if user_attributes.nil?
      user_attributes.symbolize_keys!
      user = User.new(user_attributes)
      required_attributes = user.identity.twitter? ? %i(email role_ids) : %i(role_ids)
      attributes = params.require(:user).permit(required_attributes)
      user.assign_attributes(attributes.merge(password: Devise.friendly_token))
      user.skip_confirmation! unless user.identity.twitter?
      user
    end
  end
end
