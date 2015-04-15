module Base
  class CalendarsController < Base::BaseController
    before_action :events, only: [:edit]

    def show
      @events = @profile.owned_events
      @events = @events.filtered(filter_params) if params[:filters].present?
    end

    def edit
    end

    private

    def filter_params
      params.require(:filters).permit(:source_place_id, :date)
    end

    def events
      @events = @profile.owned_events.page(params[:page]).with_status(params[:filter])
    end
  end
end
