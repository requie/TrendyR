module Admin
  class ArtistsController < Admin::AdminController
    def index
      @artists = Artist.order(created_at: :asc).includes(:profile).page(params[:page])
    end

    def featured_update
      Artist.batch_update(*artists_params)
      redirect_to admin_artists_path
    end

    private

    def artists_params
      required_params = params.require(:artists).permit!
      required_params.values.each_with_object([[], []]) do |data, obj|
        obj[0] << data[:id]
        obj[1] << data.slice(:is_featured)
      end
    end
  end
end
