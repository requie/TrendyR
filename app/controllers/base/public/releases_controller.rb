module Base
  module Public
    class ReleasesController < Public::BaseController
      def index
        @releases = @profile.entity.releases
        unless @releases.empty?
          @release = @releases.find_by(id: params[:album_id]) || @releases.first
        end
      end
    end
  end
end
