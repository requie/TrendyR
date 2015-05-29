module Base
  module Public
    class ProfilesController < Base::Public::BaseController
      def show
        @profile = Profile.find(params[:id]).decorate
      end
    end
  end
end
