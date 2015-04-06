module Base
  class CalendarsController < Base::BaseController
    before_action :events

    def show
    end

    def edit
    end

    private

    def events
      @events = @profile.owned_events.page(params[:page]).with_status(params[:filter])
    end
  end
end
