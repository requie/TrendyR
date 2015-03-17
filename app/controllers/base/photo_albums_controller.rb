module Base
  class PhotoAlbumsController < Base::BaseController
    before_action :set_photo_album, only: [:edit, :update, :show_private, :show]
    before_action :set_photos, only: [:edit, :show_private, :show]

    def show
      render action: 'show_private' if current_user.profile == @photo_album.owner_profile
    end

    def show_private
    end

    def new
      @photo_album = PhotoAlbum.new
    end

    def create
      @photo_album = PhotoAlbum.new(photo_album_params)
      @photo_album.owner_profile = current_user.profile
      @photo_album.save
    end

    def edit
      photos = []
      @photos.each { |p| photos << { url: Dragonfly.app.remote_url_for(p.attachment_uid), id: p.id } }
      gon.photos = photos
    end

    def update
      photo_handling
      @photo_album.update(photo_album_params)
      redirect_to base_profile_photo_album_path(@profile, @photo_album)
    end

    private

    def photo_album_params
      params.require(:photo_album).permit(:title)
    end

    def photo_handling
      photo_ids = params['photo_ids'].split(',')
      photo_ids.map do |pid|
        pid = pid.to_i
        @photo_album.photos << current_user.photos.find(pid) unless @photo_album.photo_ids.include?(pid)
      end if photo_ids.any?
    end

    def set_photos
      @photos = @photo_album.photos.decorate
    end

    def set_photo_album
      @photo_album = @profile.owned_photo_albums.find(params[:id])
    end
  end
end
