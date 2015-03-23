module Base
  class GalleriesController < Base::BaseController
    def show
    end

    def edit
      @photo_albums = PhotoAlbum.page(params[:page]).decorate
    end
  end
end
