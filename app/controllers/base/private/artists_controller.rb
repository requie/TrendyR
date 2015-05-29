module Base
  module Private
    class ArtistsController < Base::BaseController
      def index
        @artists = []
      end
    end
  end
end
