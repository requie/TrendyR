module Base
  class MyGigsController < Base::BaseController
    before_action :set_gigs, only: [:edit]

    def edit
    end

    def show
      @q = @profile.owned_gigs.ransack(params[:q])
      @gigs = @q.result.includes(:location)
    end

    def destroy
      @profile.filter_gigs(destroy_gigs_params).destroy_all
      respond_with :gig, location: edit_base_profile_calendar_path(@profile)
    end

    private

    def set_gigs
      @gigs = @profile.owned_gigs.page(params[:page]).with_status(params[:filter])
    end

    def filter_params
      params.require(:filters).permit(:source_place_id, :date)
    end

    def location_params
      params.permit(:source_id)
    end

    def destroy_gigs_params
      params.require(:gig_ids)
    end
  end
end
