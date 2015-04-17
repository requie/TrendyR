module Base
  class EventsController < Base::BaseController
    include LocationProcessing

    EVENT_ATTRIBUTES = %i(photo_id title description_text started_at finished_at price)

    before_action :set_event, only: [:edit, :update]
    before_action :set_events, only: [:edit]

    def index
      @events = @profile.owned_events.page(params[:page]).with_status(params[:filter])
    end

    def show
      @q = @profile.owned_events.ransack(params[:q])
      @events = @q.result.includes(:location)
    end

    def new
      @event = Event.new
    end

    def create
      @event = Event.new(event_params)
      @event.owner_profile = @profile
      create_location(@event)
      @event.save
      respond_with @event, location: base_profile_events_path
    end

    def edit
    end

    def update
      create_location(@event)
      @event.update(event_params)
      respond_with @event, location: base_profile_events_path
    end

    def destroy
      @profile.delete_events(destroy_events_params)
      redirect_to action: :index
    end

    private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(EVENT_ATTRIBUTES)
    end

    def filter_params
      params.require(:filters).permit(:source_place_id, :date)
    end

    def destroy_events_params
      params.require(:event_ids)
    end

    def set_events
      @events = @profile.owned_events.with_status(params[:filter]).page(params[:page])
    end
  end
end
