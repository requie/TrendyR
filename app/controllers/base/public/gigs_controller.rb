module Base
  module Public
    class GigsController < Public::BaseController
      def index
        @q = @profile.owned_gigs.ransack(filter_params)
        @gigs = @q.result.includes(:location)
        @profile = @profile.decorate
      end

      private

      def filter_params
        params[:q] && params[:q].permit(policy(Gig).filter_attributes)
      end
    end
  end
end
