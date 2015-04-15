module Base
  class CalendarsController < Base::BaseController
    before_action :events, only: [:edit]

    def show
      @events = @profile.owned_events
      filter_events
    end

    def edit
    end

    private

    def filter_events
      @events = @events.joins(:location).where(locations: location_params) if params.fetch(:source_id, nil).present?
      @events = @events.at_date(params[:date].to_date) if params.fetch(:date, nil).present?
    end

    def location_params
      params.permit(:source_id)
    end

    def events
      @events = @profile.owned_events.page(params[:page]).with_status(params[:filter])
    end
  end
end
