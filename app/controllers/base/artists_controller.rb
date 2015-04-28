module Base
  class ArtistsController < Base::BaseController
    before_action :set_artists

    def index
    end

    def show
    end

    private

    def set_artists
      @artists = []
    end
  end
end
