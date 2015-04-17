module Base
  class GigsController < Base::BaseController
    include LocationProcessing

    GIG_ATTRIBUTES = %i(
      title price overview_text opportunity_text band_text gig_text terms_text
      started_at finished_at photo_id
    )
    FAQ_ATTRIBUTES = %i(id question answer)

    skip_before_action :set_profile, only: :status
    before_action :set_gig, only: [:edit, :update]
    before_action :set_gigs, only: :index

    def index
      @gigs = @profile.owned_gigs.page(params[:page]).with_status(params[:filter])
    end

    def show
      @q = @profile.owned_gigs.ransack(params[:q])
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

    def status
      artist_gig = ArtistGig.find(params[:id])
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
      params.require(:filters).permit(:source_place_id, :date)
    end

    def location_params
      params.permit(:source_id)
    end

    def destroy_gigs_params
      params.require(:gig_ids)
    end
  end
end
