module Base
  class EventsController < Base::BaseController
    before_action :set_event, only: [:edit, :update]
    before_action :set_location, only: [:create, :update]

    def index
    end

    def new
    end

    def create
      @event = Event.new(event_params)
      @event.location = set_location
      @event.owner_profile = @profile
      @event.save
      redirect_to edit_base_profile_calendar_path(@profile)
    end

    def edit
    end

    def update
      @event.location = set_location
      @event.update(event_params)
      redirect_to edit_base_profile_calendar_path(@profile)
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:photo_id, :title, :description_text, :started_at, :finished_at, :price)
    end
  end
end
