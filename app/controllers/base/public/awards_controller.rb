module Base
  module Public
    class AwardsController < Public::BaseController
      def index
        @awards = @profile.owned_awards.page(params[:page]).decorate
        @profile = @profile.decorate
      end
    end
  end
end
