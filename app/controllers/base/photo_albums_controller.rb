module Base
  class PhotoAlbumsController < Base::BaseController
    before_action :set_photo_album, only: [:edit, :update, :show, :private_show]

    def show
    end

    def private_show
    end

    def new
      @photo_album = PhotoAlbum.new
    end

    def create
      @photo_album = PhotoAlbum.new(photo_album_params)
      @photo_album.owner_profile = @profile
      @photo_album.save
      redirect_to base_profile_galleries_path
    end

    def edit
      authorize @photo_album
    end

    def update
      authorize @photo_album
      @photo_album.update(photo_album_params)
      redirect_to base_profile_galleries_path
    end

    def destroy
      @profile.delete_photo_albums(destroy_photo_albums_params)
      redirect_to base_profile_galleries_path
    end

    private

    def destroy_photo_albums_params
      params.require(:photo_album_ids)
    end

    def photo_album_params
      params.require(:photo_album).permit(:title, photo_ids: [])
    end

    def set_photo_album
      @photo_album = PhotoAlbum.find(params[:id]).decorate
    end
  end
end
