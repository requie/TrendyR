module Base
  class CalendarsController < Base::BaseController
    before_action :set_events, only: [:edit]

    def show
      @q = @profile.owned_events.ransack(params[:q])
      @events = @q.result.includes(:location)
    end

    def edit
    end

    def destroy
      @profile.filter_events(destroy_events_params).destroy_all
      respond_with :event, location: edit_base_profile_calendar_path(@profile)
    end

    private

    def filter_params
      params.require(:filters).permit(:source_place_id, :date)
    end

    def destroy_events_params
      params.require(:event_ids)
    end

    def set_events
      @events = @profile.owned_events.page(params[:page]).with_status(params[:filter])
    end
  end
end
