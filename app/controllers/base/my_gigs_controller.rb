module Base
  class MyGigsController < Base::BaseController
    before_action :gigs

    def edit
    end

    private

    def gigs
      @gigs = @profile.owned_gigs.page(params[:page]).with_status(params[:filter])
    end
  end
end
