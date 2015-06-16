module Base
  module Resources
    class GigsController < Resources::BaseController
      def show
        @gig = Gig.find(params[:id])
        @comments = @gig.comments.recent.all
      end
    end
  end
end