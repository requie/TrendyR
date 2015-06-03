module Base
  module Public
    class PhotoAlbumsController < Public::BaseController
      def index
        @photo_albums = @profile.owned_photo_albums.page(params[:page]).decorate
      end

      def show
        @photo_album = PhotoAlbum.find(params[:id]).decorate
      end
    end
  end
end
