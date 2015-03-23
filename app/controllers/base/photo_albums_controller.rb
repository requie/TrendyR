module Base
  class PhotoAlbumsController < Base::BaseController
    before_action :set_photo_album, only: [:edit, :update, :show, :destroy]

    def show
      template = @photo_album.owned_by?(current_user.profile) ? 'show_private' : 'show'
      render template
    end

    def new
      @photo_album = PhotoAlbum.new
    end

    def create
      @photo_album = PhotoAlbum.new(photo_album_params)
      @photo_album.owner_profile = current_user.profile
      @photo_album.save
      redirect_to edit_base_profile_gallery_path(@photo_album.owner_profile)
    end

    def edit
      authorize @photo_album
    end

    def update
      authorize @photo_album
      @photo_album.update(photo_album_params)
      redirect_to base_profile_photo_album_path(@profile, @photo_album)
    end

    def destroy
      authorize @photo_album
      @photo_album.destroy
      photo_albums = Kaminari.paginate_array(@profile.owned_photo_albums).page(params[:page])
      @photo_albums = photo_albums.map do |photo_album|
        {
          id: photo_album.id,
          title: photo_album.title,
          first_photo: photo_album.first_photo.url,
          remaining_photos: photo_album.remaining_photos,
          date_of_creation: photo_album.date_of_creation,
          number_of_photos: photo_album.number_of_photos
        }
      end
    end

    private

    def photo_album_params
      params.require(:photo_album).permit(:title, photo_ids: [])
    end

    def set_photo_album
      @photo_album = PhotoAlbum.find(params[:id]).decorate
    end
  end
end
