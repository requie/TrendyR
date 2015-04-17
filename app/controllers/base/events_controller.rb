module Base
  class EventsController < Base::BaseController
    include LocationProcessing

    EVENT_ATTRIBUTES = %i(photo_id title description_text started_at finished_at price)

    before_action :set_event, only: [:edit, :update]
    before_action :set_events, only: [:edit]

    def index
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      @event.owner_profile = @profile
      create_location(@event)
      @event.save
      respond_with @event, location: edit_base_profile_calendar_path(@profile)
    end

    def edit
    end

    def update
      create_location(@event)
      @event.update(event_params)
      respond_with @event, location: edit_base_profile_calendar_path(@profile)
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(*EVENT_ATTRIBUTES)
    end
  end
end
