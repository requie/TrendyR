module Base
  class CalendarsController < Base::BaseController
    before_action :set_events, only: [:show, :edit]

    def show
    end

    def edit
    end

    def set_events
      @events = @profile.owned_events.page(params[:page]).decorate
    end
  end
end
