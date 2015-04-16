module Base
  class GalleriesController < Base::BaseController
    before_action :set_photo_albums, only: [:show, :edit]

    def show
    end

    def edit
    end

    def destroy
      @profile.filter_photo_albums(destroy_photo_albums_params).destroy_all
      respond_with :photo_album, location: edit_base_profile_gallery_path(@profile)
    end

    private

    def destroy_photo_albums_params
      params.require(:photo_album_ids)
    end

    def set_photo_albums
      @photo_albums = @profile.owned_photo_albums.page(params[:page]).decorate
    end
  end
end
