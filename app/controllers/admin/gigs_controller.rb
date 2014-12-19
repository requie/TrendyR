module Admin
  class GigsController < Admin::AdminController
    def index
      @gigs = Gig.order(created_at: :asc).page(params[:page])
    end

    def featured_update
      Gig.batch_update(*gigs_params)
      redirect_to admin_gigs_path
    end

    private

    def gigs_params
      required_params = params.require('gigs').permit!
      required_params.values.each_with_object([[], []]) do |data, obj|
        obj[0] << data[:id]
        obj[1] << data.slice(:is_featured)
      end
    end
  end
end
