module Base
  module Public
    class BaseController < Base::BaseController
      private

      def authorize_namespace!
        authorize :base_public, :access?
      end

      def set_profile
        @profile = Profile.find(params[:profile_id])
      end
    end
  end
end
