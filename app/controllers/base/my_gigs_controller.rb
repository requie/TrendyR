module Base
  class MyGigsController < Base::BaseController
    def edit
      gigs
    end

    def show
    end

    def destroy
      @profile.filter_gigs(destroy_gigs_params).destroy_all
      gigs
    end

    private

    def destroy_gigs_params
      params.require(:gig_ids)
    end

    def gigs
      @gigs = @profile.owned_gigs.page(params[:page]).with_status(params[:filter])
    end
  end
end
