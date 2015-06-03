module Base
  module Public
    class ProfilesController < Public::BaseController
      def show
        @profile = @profile.decorate
      end
    end
  end
end
