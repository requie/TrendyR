module Base
  class GigsController < Base::BaseController
    include LocationProcessing

    before_action :set_profile, except: [:set_request_status]

    GIG_ATTRIBUTES = %i(
      title price overview_text opportunity_text band_text gig_text terms_text
      started_at finished_at photo_id
    )
    FAQ_ATTRIBUTES = %i(id question answer)

    before_action :set_gig, only: [:edit, :update]

    def new
      @gig = Gig.new
    end

    def create
      @gig = Gig.new(gig_params)
      @gig.owner_profile = @profile
      create_location(@gig)
      @gig.save
      redirect_to edit_base_profile_my_gigs_path(@profile)
    end

    def edit
    end

    def update
      @gig.update(gig_params)
      redirect_to edit_base_profile_my_gigs_path(@profile)
    end

    def set_request_status
      artist_gig = ArtistGig.find(params[:id])
      artist_gig.update(status: params[:status])
      @artist_gigs = ArtistGig.with_status(:pending).decorate
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
