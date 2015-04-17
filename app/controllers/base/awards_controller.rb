module Base
  class AwardsController < Base::BaseController
    before_action :set_award, only: [:edit, :update]

    def index
      @awards = @profile.owned_awards
    end

    def show
      @awards = @profile.owned_awards.page(params[:page]).decorate
    end

    def new
      @award = Award.new
    end

    def create
      @award = Award.create(new_award_params)
      respond_with(@award, location: base_profile_awards_path)
    end

    def edit
    end

    def update
      @award.update(award_params)
      respond_with(@award, location: base_profile_awards_path)
    end

    def destroy
      @profile.delete_awards(award_ids)
      redirect_to action: :index
    end

    private

    def new_award_params
      award_params.merge(owner_profile: @profile)
    end

    def award_params
      params.require(:award).permit(policy(Award).permitted_attributes)
    end

    def set_award
      @award = Award.find(params[:id])
      authorize @award, "#{action_name}?"
    end

    def award_ids
      params.fetch(:award_ids, [])
    end
  end
end
