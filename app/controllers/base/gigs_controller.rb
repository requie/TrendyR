module Base
  class GigsController < Base::BaseController
    include LocationProcessing

    before_action :set_profile, except: [:set_request_status]

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
      respond_with @gig, location: edit_base_profile_my_gigs_path(@profile)
    end

    def edit
    end

    def update
      create_location(@gig)
      @gig.update(gig_params)
      respond_with @gig, location: edit_base_profile_my_gigs_path(@profile)
    end

    def set_request_status
      artist_gig = ArtistGig.find(params[:id])
      artist_gig.update(status: params[:status])
      head :ok
    end

    private

    def gig_params
      params.require(:gig).permit(*GIG_ATTRIBUTES, faqs_attributes: FAQ_ATTRIBUTES)
    end

    def set_gig
      @gig = Gig.find(params[:id])
    end
  end
end
