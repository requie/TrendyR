module Base
  class ArtistsController < Base::BaseController
    def show
      authorize @profile
    end
  end
end
