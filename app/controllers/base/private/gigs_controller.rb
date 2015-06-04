module Base
  module Private
    class GigsController < Private::BaseController
      include LocationProcessing

      before_action :set_gig, only: [:edit, :update]
      before_action :authorize_gig, only: [:index, :new, :create, :destroy]

      def index
        @gigs = policy_scope(Gig).with_status(params[:filter]).page(params[:page])
      end

      def new
        @gig = Gig.new
      end

      def create
        @gig = Gig.new(gig_params) do |gig|
          gig.owner_profile = @profile
          gig.location = find_or_create_location
        end
        @gig.save
        respond_with @gig, location: private_gigs_path
      end

      def edit
      end

      def update
        @gig.attributes = gig_params
        @gig.location = find_or_create_location
        @gig.save
        respond_with @gig, location: private_gigs_path
      end

      def destroy
        @profile.delete_gigs(destroy_gigs_params)
        redirect_to action: :index
      end

      private

      def authorize_gig
        authorize Gig
      end

      def gig_params
        params.require(:gig).permit(policy(Gig).permitted_attributes)
      end

      def set_gig
        @gig = Gig.find(params[:id])
        authorize @gig
      end

      def destroy_gigs_params
        params.require(:gig_ids)
      end
    end
  end
end
