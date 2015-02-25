module Base
  class ProfilesController < Base::BaseController
    before_action :set_profile, only: [:edit, :update]

    def show
      @profile = Profile.find(params[:id])
      authorize @profile
    end

    def edit
      authorize @profile
    end

    def update
      authorize @profile
      set_location
      @profile.update(profile_params)
      respond_with(@profile, location: base_profile_path)
    end

    private

    def profile_params
      params.require(:profile).permit(*policy(@profile).permitted_attributes)
    end

    def set_location
      location = Location.find_or_create_by(location_params) do |l|
        l.creator = @profile.user
      end
      @profile.location = location
    end

    def location_params
      params.require(:location).permit(*policy(:location).permitted_attributes)
    end

    def set_profile
      @profile = ProfileDecorator.find(params[:id])
    end
  end
end
