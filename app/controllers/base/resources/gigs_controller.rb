module Base
  module Resources
    class GigsController < Resources::BaseController
      def show
        @gig = Gig.find(params[:id])
      end
    end
  end
end
