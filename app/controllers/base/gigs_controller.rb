module Base
  class GigsController < Base::BaseController
    def show
      authorize @profile
    end
  end
end
