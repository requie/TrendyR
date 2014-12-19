module Base
  class AwardsController < Base::BaseController
    before_action :set_award, only: [:edit, :update]

    def index
    end

    def new
      @award = Award.new
    end

    def create
      @award = Award.new(new_award_params)
      @award.save
      respond_with(@award, location: base_awards_path)
    end

    def edit
    end

    def update
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
