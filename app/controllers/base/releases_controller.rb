module Base
  class ReleasesController < Base::BaseController
    def show
      authorize @profile
    end
  end
end
