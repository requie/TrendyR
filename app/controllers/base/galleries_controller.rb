module Base
  class GalleriesController < Base::BaseController
    before_action :set_photo_albums, only: [:show, :edit]

    def show
    end

    def edit
    end

    private

    def set_photo_albums
      @photo_albums = @profile.owned_photo_albums.page(params[:page]).decorate
    end
  end
end
