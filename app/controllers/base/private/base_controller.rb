module Base
  module Private
    class BaseController < ApplicationController
      layout 'base/main'
      respond_to :html, :json

      before_action :authorize_namespace!

      private

      def authorize_namespace!
        authorize :base_private, :access?
      end
    end
  end
end
