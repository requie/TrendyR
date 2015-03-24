module Base
  class GalleriesController < Base::BaseController
    def show
    end

    def edit
      @photo_albums = @profile.owned_photo_albums.page(params[:page]).decorate
    end
  end
end
