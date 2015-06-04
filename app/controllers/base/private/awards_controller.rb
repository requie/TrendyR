module Base
  module Private
    class AwardsController < Private::BaseController
      before_action :authorize_award, except: [:edit, :update]
      before_action :set_award, only: [:edit, :update]

      def index
        @awards = @profile.owned_awards
      end

      def new
        @award = Award.new
      end

      def create
        @award = Award.create(award_params) do |award|
          award.owner_profile = @profile
        end
        respond_with(@award, location: private_awards_path)
      end

      def edit
      end

      def update
        @award.update(award_params)
        respond_with(@award, location: private_awards_path)
      end

      def destroy
        @profile.delete_awards(award_ids)
        redirect_to action: :index
      end

      private

      def award_params
        params.require(:award).permit(policy(Award).permitted_attributes)
      end

      def set_award
        @award = Award.find(params[:id])
        authorize @award
      end

      def award_ids
        params.fetch(:award_ids, [])
      end

      def authorize_award
        authorize Award
      end
    end
  end
end
