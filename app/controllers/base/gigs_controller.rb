module Base
  class GigsController < Base::BaseController
    include LocationProcessing

    GIG_ATTRIBUTES = %i(
      title price overview_text opportunity_text band_text gig_text terms_text
      started_at finished_at photo_id
    )
    FAQ_ATTRIBUTES = %i(id question answer)
    FILTER_ATTRIBUTES = %i(started_at_lteq finished_at_gteq location_source_place_id_eq location_address_eq)

    skip_before_action :set_profile, only: :state
    before_action :set_gig, only: [:edit, :update]
    before_action :set_gigs, only: :index

    def index
    end

    def show
      @q = @profile.owned_gigs.ransack(filter_params)
      @gigs = @q.result.includes(:location)
    end

    def overview
    end

    def new
      @gig = Gig.new
    end

    def create
      @gig = Gig.new(gig_params)
      @gig.owner_profile = @profile
      create_location(@gig)
      @gig.save
      respond_with @gig, location: base_profile_gigs_path
    end

    def edit
    end

    def update
      create_location(@gig)
      @gig.update(gig_params)
      respond_with @gig, location: base_profile_gigs_path
    end

    def destroy
      @profile.delete_gigs(destroy_gigs_params)
      redirect_to action: :index
    end

    def state
      artist_gig = Booking.find(params[:id])
      status = artist_gig.update(status: params[:status]) ? :ok : :unprocessable_entity
      head status
    end

    private

    def gig_params
      params.require(:gig).permit(*GIG_ATTRIBUTES, faqs_attributes: FAQ_ATTRIBUTES)
    end

    def set_gig
      @gig = Gig.find(params[:id])
    end

    def set_gigs
      @gigs = @profile.owned_gigs.with_status(params[:filter]).page(params[:page])
    end

    def filter_params
      params.require(:q).permit(FILTER_ATTRIBUTES)
    end

    def destroy_gigs_params
      params.require(:gig_ids)
    end
  end
end
