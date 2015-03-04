module Base
  class ProfilesController < Base::BaseController
    before_action :set_profile, only: [:show, :edit, :update, :artists, :calendar, :gallery, :releases, :awards, :gigs]

    def show
      authorize @profile
      @gigs = @profile.owned_gigs.ordered if @profile.owned_gigs
      @events = @profile.owned_events.ordered if @profile.owned_events
      @awards = @profile.owned_awards.ordered if @profile.owned_awards
      gon.location = @profile.location
    end

    def edit
      authorize @profile
    end

    def artists
      authorize @profile
      gon.location = @profile.location
    end

    def awards
      authorize @profile
      gon.location = @profile.location
    end

    def gigs
      authorize @profile
      gon.location = @profile.location
    end

    def calendar
      authorize @profile
      gon.location = @profile.location
    end

    def gallery
      authorize @profile
      gon.location = @profile.location
    end

    def releases
      authorize @profile
      gon.location = @profile.location
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
      @profile = Profile.find(params[:id]).decorate
    end
  end
end
