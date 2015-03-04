module Base
  class AwardsController < Base::BaseController
    before_action :set_award, only: [:edit, :update]

    def index
      @awards = policy_scope(Award)
    end

    def show
      authorize @profile
    end

    def new
      @award = Award.new
      authorize @award
    end

    def create
      @award = Award.new(new_award_params)
      authorize @award
      @award.save
      respond_with(@award, location: base_awards_path)
    end

    def edit
      authorize @award
    end

    def update
      authorize @award
      @award.update(award_params)
      respond_with(@award, location: base_awards_path)
    end

    private

    def new_award_params
      award_params.merge(owner_profile: @profile)
    end

    def award_params
      params.require(:award).permit(:title, :description_text, :earned_at)
    end

    def set_award
      @award = Award.find(params[:id])
    end
  end
end
