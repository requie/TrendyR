module Base
  class HomeController < Base::BaseController
    def show
      authorize @profile
      @gigs = @profile.owned_gigs.ordered
      @events = @profile.owned_events.ordered
      @awards = @profile.owned_awards.ordered
    end

    def edit
      authorize @profile
    end

    def update
      authorize @profile
      set_location
      @profile.update(profile_params)
      respond_with(@profile, location: edit_base_home_path)
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
  end
end
