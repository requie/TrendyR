module Base
  module Private
    class ProfilesController < Base::Private::BaseController
      include LocationProcessing

      before_action :authorize_profile

      def show
        @profile = @profile.decorate
      end

      def update
        @profile.assign_attributes(profile_params)
        @profile.location = find_or_create_location
        @profile.save
        respond_with(@profile, location: private_profile_path)
      end

      def update_photo
        @profile.update!(profile_photo_params)
        head :ok
      end

      private

      def authorize_profile
        authorize @profile
      end

      def profile_params
        params.require(:profile).permit(policy(@profile).permitted_attributes)
      end

      def profile_photo_params
        params.require(:profile).permit(:photo_id, :wallpaper_id)
      end
    end
  end
end
