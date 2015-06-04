module Base
  module Private
    class ArtistsController < BaseController
      def index
        @artists = []
      end
    end
  end
end
