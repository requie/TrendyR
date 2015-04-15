module Base
  class MyGigsController < Base::BaseController
    def edit
      gigs
    end

    def show
      @gigs = @profile.owned_gigs
      @gigs = @gigs.filtered(filter_params) if params[:filters].present?
    end

    def destroy
      @profile.filter_gigs(destroy_gigs_params).destroy_all
      gigs
    end

    private

    def gigs
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
