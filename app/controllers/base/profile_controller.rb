module Base
  class ProfileController < Base::BaseController
    include LocationProcessing

    def show
    end

    def edit
    end

    def update
      create_location(@profile)
      @profile.update(profile_params)
      respond_with(@profile, location: edit_base_profile_path)
    end

    def update_photo
      set_profile
      @profile.update(profile_photo_params)
      head :ok
    end

    private

    def profile_params
      params.require(:profile).permit(*policy(@profile).permitted_attributes)
    end

    def profile_photo_params
      params.require(:profile).permit(:photo_id, :wallpaper_id)
    end
  end
end
