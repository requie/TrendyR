module Base
  module Private
    class PhotoAlbumsController < Private::BaseController
      before_action :set_photo_album, only: [:edit, :update]
      before_action :authorize_photo_album, only: [:index, :new, :create, :destroy]

      def index
        @photo_albums = @profile.owned_photo_albums.page(params[:page]).decorate
      end

      def show
        @photo_album = PhotoAlbum.find(params[:id]).decorate
      end

      def new
        @photo_album = PhotoAlbum.new
      end

      def create
        @photo_album = PhotoAlbum.new(photo_album_params) do |photo_album|
          photo_album.owner_profile = @profile
        end
        @photo_album.save
        respond_with(@photo_album, location: private_photo_albums_path)
      end

      def edit
      end

      def update
        @photo_album.update(photo_album_params)
        respond_with(@photo_album, location: private_photo_albums_path)
      end

      def destroy
        @profile.delete_photo_albums(destroy_photo_albums_params)
        redirect_to action: :index
      end

      private

      def photo_album_params
        params.require(:photo_album).permit(policy(PhotoAlbum).permitted_attributes)
      end

      def destroy_photo_albums_params
        params.require(:photo_album_ids)
      end

      def set_photo_album
        @photo_album = PhotoAlbum.find(params[:id])
        authorize @photo_album
      end

      def authorize_photo_album
        authorize PhotoAlbum
      end
    end
  end
end
