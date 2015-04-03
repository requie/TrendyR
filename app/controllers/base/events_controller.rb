module Base
  class EventsController < Base::BaseController
    include LocationProcessing

    EVENT_ATTRIBUTES = %i(photo_id title description_text started_at finished_at price)

    before_action :set_event, only: [:edit, :update]
    before_action :create_location, only: [:create, :update]

    def index
    end

    def new
    end

    def create
      @event = Event.new(event_params)
      @event.owner_profile = @profile
      @event.save
      redirect_to edit_base_profile_calendar_path(@profile)
    end

    def edit
    end

    def update
      @event.update(event_params)
      redirect_to edit_base_profile_calendar_path(@profile)
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(*EVENT_ATTRIBUTES).merge(location_id: create_location.id)
    end
  end
end
