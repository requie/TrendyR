module Base
  class ReleasesController < Base::BaseController
    before_action :set_release, only: [:edit, :update]

    SEARCH_ATTRIBUTES = %i(title_cont)

    def index
      @q = @profile.entity.songs.includes(:release).search(search_params)
      @songs = @q.result
    end

    def list
      @songs = Song.none
    end

    def show
      @releases = @profile.entity.releases
      unless @releases.empty?
        @release = @releases.find_by(id: params[:album_id]) || @releases.first
      end
    end

    def new
      @release = Release.new
    end

    def create
      @release = Release.new(release_params)
      @release.artist = @profile.entity
      @release.save
      respond_with @release, location: base_profile_releases_path
    end

    def edit
    end

    def update
      @release.update(release_params)
      respond_with @release, location: base_profile_releases_path
    end

    private

    def release_params
      params.require(:release).permit(:title, :description_text, :photo_id, song_ids: [])
    end

    def search_params
      params[:q] ? params[:q].permit(:title_cont) : nil
    end

    def set_release
      @release = Release.find(params[:id])
    end
  end
end
