module Base
  module Private
    class ReleasesController < Private::BaseController
      before_action :set_release, only: [:edit, :update]

      def index
        @q = @profile.entity.songs.includes(:release).ransack(search_params)
        @songs = @q.result
      end

      def list
        @songs = Song.none
      end

      def new
        @release = Release.new
      end

      def create
        @release = Release.new(release_params) do |release|
          release.artist = @profile.entity
        end
        @release.save
        respond_with @release, location: private_releases_path
      end

      def edit
      end

      def update
        @release.update(release_params)
        respond_with @release, location: private_releases_path
      end

      private

      def release_params
        params.require(:release).permit(policy(Release).permitted_attributes)
      end

      def search_params
        params[:q] && params[:q].permit(:title_cont)
      end

      def set_release
        @release = Release.find(params[:id])
      end
    end
  end
end
