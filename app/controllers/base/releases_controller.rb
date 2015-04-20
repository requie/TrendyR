module Base
  class ReleasesController < Base::BaseController
    def new
      @release = Release.new
    end

    def create
      @release = Release.new(release_params)
      @release.save
    end

    private

    def release_params
      params.require(:release).permit(:title, :description_text)
    end
  end
end
