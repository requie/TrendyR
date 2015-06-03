module Base
  module Resources
    class BaseController < Base::BaseController
      private

      def set_profile
        @profile = current_user.profile
      end

      def authorize_namespace!
        authorize :base_private, :access?
      end
    end
  end
end
