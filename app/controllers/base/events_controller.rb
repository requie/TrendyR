module Base
  class EventsController < Base::BaseController
    include LocationProcessing

    EVENT_ATTRIBUTES = %i(photo_id title description_text started_at finished_at price)

    before_action :set_event, only: [:edit, :update]

    def index
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      @event.owner_profile = @profile
      set_location(@event)
      @event.save
      redirect_to edit_base_profile_calendar_path(@profile)
    end

    def edit
    end

    def update
      @event.update(event_params)
      redirect_to edit_base_profile_calendar_path(@profile)
    end

    def destroy
      @profile.filter_events(destroy_events_params).destroy_all
      @events = @profile.owned_events.page(params[:page])
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def destroy_events_params
      params.require(:event_ids)
    end

    def event_params
      params.require(:event).permit(*EVENT_ATTRIBUTES)
    end
  end
end
