module Base
  class GalleryController < Base::BaseController
    def show
      authorize @profile
    end
  end
end
