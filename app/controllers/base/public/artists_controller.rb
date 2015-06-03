module Base
  module Public
    class ArtistsController < Public::BaseController
      def index
        @artists = []
      end
    end
  end
end
